import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClient } from '@/lib/supabase';
import { getSession } from '@/lib/auth';

export const dynamic = 'force-dynamic';

// GET /api/portfolio — return user's saved vendors
export async function GET() {
  const user = await getSession();
  if (!user) return NextResponse.json({ error: 'unauthorized' }, { status: 401 });

  const supabase = createSupabaseClient();
  const { data, error } = await supabase
    .from('user_portfolio_summary')
    .select('*')
    .eq('user_id', user.id);

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ portfolio: data });
}

// POST /api/portfolio — add vendor to stack
export async function POST(req: NextRequest) {
  const user = await getSession();
  if (!user) return NextResponse.json({ error: 'unauthorized' }, { status: 401 });

  const { vendor_id } = await req.json();
  if (!vendor_id) return NextResponse.json({ error: 'vendor_id required' }, { status: 400 });

  const supabase = createSupabaseClient();
  const { error } = await supabase
    .from('user_portfolios')
    .upsert({ user_id: user.id, vendor_id }, { onConflict: 'user_id,vendor_id' });

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ ok: true });
}

// DELETE /api/portfolio — remove vendor from stack
export async function DELETE(req: NextRequest) {
  const user = await getSession();
  if (!user) return NextResponse.json({ error: 'unauthorized' }, { status: 401 });

  const { vendor_id } = await req.json();
  if (!vendor_id) return NextResponse.json({ error: 'vendor_id required' }, { status: 400 });

  const supabase = createSupabaseClient();
  const { error } = await supabase
    .from('user_portfolios')
    .delete()
    .eq('user_id', user.id)
    .eq('vendor_id', vendor_id);

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ ok: true });
}
