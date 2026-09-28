Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146904D9F69
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604910; cv=none; b=D0NvQWMe7M4LYrrPhAUq0hL80bATBOO6JD2TnNd0ZS58T7WKeiSwYkQGea7UQ+M0WYbLuTZdnIE57VjSHEk/DJ6kE0eCqASNBroKThTvGFQm7IONZAhP2eE4zi4RZ3p2I48CYnCj0N5mCgf22E55VPOxh8kSeBFNrXJRCcPZD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604910; c=relaxed/simple;
	bh=Dprqn4Ar05NKWfcv6AKST9SoRuM4hD7dNWbzHAQ/Y7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfMyzDsbZ/77JleLTOOYOGt0psWv7bbvzkff6fafrU62KWAO84R/MNVfSgAG3XA67D9qVWpQBZ1qJQ1kToZyZuFTxxVAvjmPfrLLluYOrqLaeTtdeXLM5IqvNsDrnVMP+lj1Xpf8NPjReu94ZwOZ9nj1FLNTePbkiOLSni1HFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ7FVCYz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ7FVCYz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so24423345e9.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790604906; x=1791209706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UcBsTVtOfdT5k8Q+5eRoFGp+XhC6w5cbeOrMwK1r4Jc=;
        b=DZ7FVCYzwtQ99zvItyUMhdJgts7EbkKrnp2I77mAzp6VzAP5gWRO5j+fTt86eQpTtL
         ZF4YV6Bazx6FC7UsVJIQYlrPAt/cbL3O0ezmzZENeaCA4vdDzSv6F0zIQsvBu9r706K9
         V4Jds3MV3s8cgmrEPDIWuLKkPsQR25YtExzuagBwubTKL+D8TK76SvW1ZkjETB67AqcN
         4dimXb2dVKT4LW3ZVfN8JNiB7qB+bk72bKUmL9WeKFBLU+n9oiSlnqTiGvQEmUSIRMYH
         Au3EzdHwbD3H/jLJu3cLPZsykZRD/so1+FNSVpkWXo/dNh7W0thXhg3XX1wkdQmT+6BZ
         RCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790604906; x=1791209706;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcBsTVtOfdT5k8Q+5eRoFGp+XhC6w5cbeOrMwK1r4Jc=;
        b=Dg5SXWO9qIQA+bMIDWwH048Fjv5L7ukonBThAV78jcgnlBhxBJUF3DZXUwYV4EdqTG
         0GWpdnChw2EO5wSIU5V2PJ1/AFRyC/EqZgY37oGNmlHIwvP4D4hGdg+t5a+wSyg88DNS
         3AjmlUM8uvtPUFe8m9zjwvo6dNIIprWn9T+Bk7cllBcBeUYfJxj1pRx58lkfibyAYeLk
         jiIoXlPZW6qs1P062i8nZh6Kr7BzB2VRMrXhc0ZzQfX8X6wvvP5lZxXcBRvJVKTmt177
         GjWbRn3TTLn1GXCvXHQeFEgB03v+njdraI98zKq9G9y/NntIQz5uCpXmYP3yWk/3adgv
         qClQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxMZDySreEl8eQxccNQd/v91ULcZ2wIOab/8QXEmnw9lIdsx/k2eQDrF4p7rR3aVz8/uE=@vger.kernel.org
X-Gm-Message-State: AFuF++lG+27gyv5Q88H8wQ9fy5ezwUOdq8XMQ6EnDC79nqZGC6OS1Qke
	xamuW3Fs+5t5uBCYzC5WfmqGxm6fGF28N4uAclICWXaTOjzPiyC/DWKB
X-Gm-Gg: AYBFou1WloA015XWXlOZXjAEqnUoxby6sLonJcElh4Yjubzd6c6v0o/5TPch8S4fVNZ
	rYitKVzFRwM1BivlaVpwQIOWTaAP0nAe5JV0JCVQeLv1gHngZd5T6CavxAoc7piRcJZa8QAzBca
	LZKEBRTuHbEssS4eZEu/Iqm0YfwAr0xSe1nRhIeJBshQhobMustemUsQzhM/75KHjtebmkJzJeY
	C2tdnQXwJrr3o1Qy13eSxlVSqNnIIZqisobwCX6OxyAz/reEuzBtRwdQxiQoFj50jzWxpGTN6J5
	2ivDYKDKDiaps9iW3uO916tY4e0bD69jYCnUa7x0UAHU8UiTaoUCclaBqoc5YqR9+HwSXQYX8my
	xuCwxkalrCW7iL4q3hkiKq4X00JC6nAjRAZKoU97YRcbk7Z206qKH003ddQGpR0PMuAHC21czwb
	3A7fbL5WjeICbVJPZRsftgQtl2MmXI04AQe1lfcfx+Jlm8StnNFLSxrzcwZ2+C9H+m99fdrNfm
X-Received: by 2002:a05:600d:8652:10b0:49f:feca:b3bf with SMTP id 5b1f17b1804b1-49ffecab799mr66710595e9.8.1790604905828;
        Mon, 28 Sep 2026 07:15:05 -0700 (PDT)
Received: from [10.245.244.37] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0d853asm5141065e9.1.2026.09.28.07.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:15:04 -0700 (PDT)
Message-ID: <59384511c6070abfd048b37f5ec2831e5f8bb715.camel@gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini	
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Fabiano
 Rosas	 <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta	
 <pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc
 Zyngier	 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven
 Price	 <steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel
 Ortiz	 <sameo@rivosinc.com>, Jakub =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	
 <jakub.ruzicka@matfyz.cz>, =?ISO-8859-1?Q?J=F6rg_R=F6del?=
 <joro@8bytes.org>,  Vishal Annapurve <vannapurve@google.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>, 
 Kishen Maloor <kishen.maloor@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Peter Fang	 <peter.fang@intel.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li	 <xiaoyao.li@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, 	kvm@vger.kernel.org
Date: Mon, 28 Sep 2026 17:15:00 +0300
In-Reply-To: <arWT9fwpCkFneDKn@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
	 <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>
	 <arWT9fwpCkFneDKn@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter, thanks for reply again.

On Thu, 2026-09-24 at 17:19 -0400, Peter Xu wrote:
> > > > The reason I am asking is that my assumption was that it is not imp=
ortant.
> > > > But if it is, I will come back to the TDX module architects with a
> > > > request to revise the design to support independent dirty page trac=
king. Of
> > > > course they may have some reasons for not doing it, but I would try=
 at
> > > > least.
> > >=20
> > > Thanks, I'll talk to our team and revisit this after I collect answer=
s.
> >=20
> > Many thanks!
>=20
> I got some feedback on this, I'll try to provide a summary.
>=20
> So, first of all, calc_dirty_rate isn't seem to be widely used across our
> customers.
>=20
> However, we do have customer case using calc_dirty_rate to evaluate
> migrations of a VM fleet for cases like from one data centre to another.
>=20
> I think it makes sense because the normal "try to migrate and fallback
> otherwise" idea applies well to one VM, but perhaps not that good on a
> fleet.

Yes, that makes sense.

> When a fleet is involved, we don't want to migrate 400 VMs then found
> there're 30 critical VMs too busy and can't migrate, then due to whatever
> reason (inter-VM communication / service locality ?) one is forced to
> migrate that 400 VMs backwards.
>=20
> IOW, it seems helpful to provide high-level evalutions of migration
> decisions over a full cluster, concurrently and efficiently.

Thank you. I'll work on this internally. It will take time.

Just to give wider context: Sean and Paolo gave us feedback regarding the
entire SEPT scan approach - they believe it is too costly and won't scale,
and suggested using PML instead. For now, dirty scanning is the best we
have, but I continue to explore other options internally, and standalone
dirty tracking is one of them.

> > AFAIU, the TDX guest migration implementation benchmarking results are
> > satisfactory with the scanning approach, but I do not have hard numbers=
 to
> > share. I also feel that PML could offer better performance, at least fo=
r
> > memory-intensive workloads. But this is intuition only.=09
>=20
> My gut feeling is DMA shouldn't be a blocker for PML: AFAIU we don't trac=
k
> DMA from KVM side. Assigned device should have its own dirty tracking for
> DMAs, either via device's own tracking facilities, or the IOMMU on the
> host.  Feel free to refer to vfio_listener_log_sync() in QEMU.  In all
> cases, it'll be great you could share the reason if you have more solid
> clues.

Yeah, this is also part of the internal exploration I mentioned above too.

> >=20
> Are we talking about the memory export/import API or GET_DIRTY_LOG?  IIUC=
,
> GET_DIRTY_LOG always applies to a whole memslot,
>=20
> struct kvm_dirty_log {
> 	__u32 slot;
> 	__u32 padding1;
> 	union {
> 		void *dirty_bitmap; /* one bit per page */
> 		__u64 padding2;
> 	};
> };

I apologize, I worte something unrelated to the context. 512 GPAs at a time
is the limit for exporting the memory, not for dirty scanning.

For the dirty scanning seamcall (TDH.MEM.SCAN.RANGE), the limit is 512 * 51=
2
GPAs at a time, which is 262,144 GPAs, or 1GiB. So if a memslot is larger
than 1GiB, multiple calls to the dirty scanning seamcall are needed.

> > Keep in mind that dirty pages are the majority of migration candidates,=
 but
> > not all of them. Sometimes a migration candidate can be a page that was
> > already exported, but then was, for example, converted from private to
> > shared, or unaccepted by the TD (gone, in other words). In this case th=
e TDX
> > module flags it as a migration candidate too. The memory export seamcal=
l
> > treats it differently too - instead of exporting encrypted page data, i=
t
> > exports a small record indicating that the page has changed its status
> > (gone).
>=20
> Yes, it makes sense.
>=20
> So can I inteprete this as GET_DIRTY_LOG works seamlessly for both privat=
e
> and shared pages (or even, unaccepted pages)?
>=20
> Then I assume it means MEMORY.EXPORT should also be able to read shared o=
r
> unaccepted pages too, am I right?  Same to when apply with IMPORT.  Anoth=
er
> counter example is MEMORY.EXPORT returns a flag saying "this page is
> shared, go read it directly from HVA", but then QEMU reading it may race
> with a concurrent shared->private conversion crashing VMM.
>=20
> Looks to me MEMORY.EXPORT must support shared too, then.

Hmm... First of all, it does sound like a possible approach. But it is not
the approach we took in our PoC today. I hope Kishen will chime in to
correct me.

Here is how I saw this, but I may be missing something (my excuse is that I
am still new to the team and still learning).

1. QEMU has a bitmap of shared pages in RAMBlockAttributes, so it can
   distinguish shared pages.
2. In general, QEMU does not distinguish private vs unaccepted pages, so
   unaccepted pages are treated as private pages.

Dirty tracking:

- QEMU uses the same KVM_DIRTY_LOG mechanism for tracking shared, private,
  and unaccepted pages.
- For shared GFNs, KVM uses the normal VM dirty tracking mechanism. For
  private and unaccepted GFNs, KVM goes to the TDX-specific code.
- But the final bitmap that QEMU sees covers all page types.
- KVM calls TDH.MEM.SCAN.RANGE on both private and unaccepted GFNs.
- For private GFNs, the TDX module reports it as a migration candidate if
  its data changed or its status changed (e.g., converted to shared or
  unaccepted).
- For unaccepted GFNs, the TDX module reports it as a migration candidate i=
n
  the first round (so it appears as dirty in KVM_DIRTY_LOG reply). Then it
  reports it as clean, unless its status changes - it becomes accepted.

Page export:

- QEMU migrates shared pages the old way - it does not try to use the
  proposed CoCo migration uAPI for that.
- For private and unaccepted pages, QEMU uses the CoCo migration uAPI.
- Our export uAPI PoC implementation does not try to check GFN type - it
  just   feeds them all to the TDX module TDH.EXPORT.MEM seamcall. Here
  is what TDX module does depending on the page type:
  - Shared pages: just skip, no errors.
  - Private pages: export the data in encrypted form.
  - Unaccepted pages: export a small record telling that the page is
    unaccepted. This record should be delivered to the destination and
    imported there, just like private pages.

But clearly this is part of the uAPI contract that must be discussed and
made explicit. What I describe above is obviously our PoC implementation,
plus TDX module behavior details.

> > The same logic applies to a TDX guest using dirty scanning. Suppose the
> > final dirty scan is slower than a theoretical TDX PML-based approach wo=
uld
> > have been. The prescan optimization I described in the previous e-mail
> > should help with this in an average case, but let's assume it does not
> > help for some special case - when the TD touches most of its memory, so
> > all EPT sub-trees end up touched. This should be rare, but let's assume=
 it
> > happens.
> >=20
> > In this case, whether that scan slowdown will actually matter for the
> > overall downtime also depends on the network. If the network is very fa=
st,
> > the scan itself can become the dominant part of the downtime. If the
> > network=C2=A0is the slower part, the scan slowdown may barely matter.
> >=20
> > So my understanding is that downtime is never fully predictable, for
> > either type of VM.
>=20
> Right, but IMHO background scan of EPT pgtable dirty bits adds a complete=
ly
> new reason to introduce downtime, and when I said "unpredictable", it is
> about that part.  Also, I worry in some worst case this can be pretty lar=
ge.

Just to clarify on the "background" part. Yes, it is "background" relative
to the TD - some CPU is running it, in parallel with vCPUs running on other
CPUs.

But there is no background activity in the TDX module itself. All the
seamcalls run synchronously on the CPU that invokes them.

This means, for example, that to speed up memory export, one can run the
TDH.EXPORT.MEM seamcall for different GPAs in parallel on different CPUs.

Same for dirty scanning - if one could run the TDH.MEM.SCAN.RANGE seamcall
for different GPAs in parallel on different CPUs, that would make scanning
much faster.

Also a bit separately, one point to keep in mind is that in CoCo the page
export and import are heavy, compute-intensive crypto operations. So when w=
e
talk about slower scanning, we need to keep in mind that it is not that slo=
w
in relation to the export crypto. But I understand that this is not an
apples-to-apples comparison:

- Scanning is potentially about a large SEPT in a VM with terabytes of
  memory.
- Exporting is only about the pages found to be dirty.

So this is only to remind that in the CoCo case, memory export also has a
high price tag, compared to a traditional VM.

> So we have two overheads here at this stage, unpredictable:
>=20
>   (a) Scanning EPT pgtable, when very unlucky, can take a lot of time to
>       finally reports to a GET_DIRTY_LOG request,
>=20
>   (b) Migrating of dirty pages during blackout phase, which should be
>       roughly linear to how many dirty pages we just collected.  (NOTE!  =
I
>       think we may have way to fix this (b) or optimize it.. but this is
>       off-topic; let's focus on the difference of (a) and (b) first)
>=20
> When with PML, IIUC (a) is predictable: we have the bitmap on hand, plus =
a
> maximum of some (my memory is, 512?) PML entries to flush per vCPU.
> That'll be flushed automatically when we do vm_stop(), likely also
> concurrently, atomically updating the bitmaps.  I never measured it, but =
it
> is bounded, and sounds pretty fast.

Yes, I agree.

Now my secret desire is that TDX module can eventually plug PML under the
hood, consider it a "hardware accelerator" without changing the ABI. But I
do not know whether keeping the ABI unchanged is possible, or how soon it
could happen. This is something I am working on internally with Intel TDX
module team.

> When with scanning, (a) seems more unpredictable.  That's the part I was
> slightly concerned.  But now after thinking a bit more, it seems fine.
> Please read below.

Sure, thanks.

> > Intuitively, the TDX case does feel "less predictable". The open
> > question for me is whether the degree of unpredictability is large enou=
gh
> > to bother users. My attitude is to focus on getting something simple do=
ne
> > first, learn from real-world behavior, and improve it later if needed,
> > including exploring PML. The best is the enemy of the good sort of
> > attitude.
>=20
> Yes, I think it's always fine we start with whatever is most feasible.
>=20
> I think it actually may not be that bad. The last sync is special at leas=
t
> on how QEMU treats it, it should look like:
>=20
>   - GET_DIRTY_LOG, to do last math, decide to switchover, <------   [1]
>   - vm_stop()
>   - GET_DIRTY_LOG, this collects all rest dirty bits      <------   [2]
>   - migrates the dirty pages, device states, etc.
>=20
> So I expect there should be normally very small window between two
> continuous GET_DIRTY_LOG across system.  Only [2] will be part of downtim=
e.
>=20
> Since you explained to me on how the background rescan roughly works, by
> relying on A bit in pgtable directory entries, I do feel like in this cas=
e
> most of the memory regions shouldn't be accessed during small window of
> [1]->[2], then the range to scan should be very much under control too.  =
In
> reality, it will likely be even smaller, [1]->vm_stop(), because after th=
at
> vCPUs are halted.

Yes, I agree. Just to flag the word "background" again, and to make sure we
are aligned - this "rescan" happens between [1] and [2]. The idea is that
[2] will be very fast after the "rescan". But it does increase the time
between [1] and [2], and the TD has time to dirty more pages.

> So it may not really be an issue in practise, but it still depends. In al=
l
> cases, some measurements after PoC ready would be nice on some large and
> relatively busy VMs.

Yes, I agree.
>=20

Thanks, Artem.
