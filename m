Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE43C3C0E
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895227; cv=none; b=mvsMc5ek0lzIBcYzPD6L0iKP9NC+pDlYSR2g2H05szdkmUqgBQQcdfdc6lRVPZfH2PhDojqCNxAf7TEe46v7gZfPj44vg4ac8qIfDbcu4f9KBWfYYyLJp1gMMD3wMnLk6hmLZTTCdrwerLXcjHiNdwOIhEHvwU/An9vq8oQUwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895227; c=relaxed/simple;
	bh=kZ0L8tI/+9sMcskSgHR9hZWhYuoIyAhRCzpB8MxEKT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjpCTZbX2vJ5Q9TNrn2v3pXDf4zHU+WS6o9YLkwdWr01Q+xeAfn/Ex/JNl7L29qaUDYUm/Few9HODOULVBwg/y4oAFv9hGzWcIMtoyFci2WuM5oTqgz1MWWe94MGgo8ovXEDkAOyIiSOfFgORfwjg0Pah/PD+9j9oLdDeab7K34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZMGD0Tm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZMGD0Tm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8531d89e59so2903443a12.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779895225; x=1780500025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/t6cjCwJ+6ttpGzq56PqEIbdzSib/5Ls3U9Gee7ZBQ=;
        b=gZMGD0TmaHoQyfcPOPnt89B/yzpqAhaVeGATyc4oeXduxBFvyApsUsoVnTMThuiq95
         jW86M9ArmjYQIIuuo+BGqNcHaMrvQHMb/awKrDvRl/liui4IiVWeotzwdxdJoZQXEGzy
         5hA4aTucLbPqi4JW9FatjgFsYRw5hoOXOT/bOryCl2Y2VApATZ3fVx8FIrmuMZ/DCH98
         IATjAglK4hWYcAetGAnVMw5f2VheFKrnKoYUmY3tdqm5MvH3RWAd9Oov3HmI4RqpuhEc
         R+JJ3x8qF+XDMV/dkKu4mkTucT+Rvsuhlz/PyyL2r1CfK8WNteygxStqUglSnaWETjkA
         bCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895225; x=1780500025;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F/t6cjCwJ+6ttpGzq56PqEIbdzSib/5Ls3U9Gee7ZBQ=;
        b=R3hyVH7eRCMrYNdZ0sehnJs29B07cQZClhdu9Zhn1+EXMk6gv1M31EceSRoDR9nc6j
         m8iEu9lK12oiMJ+jktVgyBzCkS2TczJzAXWbk1iavERJ82jMOuovZXAbav7cPx0/K1F2
         ic2iuD9Sag9iQVQjVKeT6QkkecCC0/UkobfYKXjTw4qjj/Hd5hOfZMKaloDx4DkJfycm
         Mem1TNivRYnzq2JIyLe+2UYYcWG6CgEN0ru1IcSOxuBmjK/dUVgULy8li6K5IQgYTnkq
         x5PghopTPVGepoC7C3nxknMeUy7+wfYyy/ZLXu/qWgZerhAvb2k+7y0lMEDKMJkcO4wl
         r6Hw==
X-Forwarded-Encrypted: i=1; AFNElJ+v1aoyd+hlBcFWq+jS+rVPu3Oa6SZ0FlEYeJwCfRFZKHwyf+rw7jVP6NLiaouu/CPGz4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt66RjiB3GGCCFmaT0WFyLjHJ9f2pgQ+f6pevodIDrTxlbROyL
	daLDy4khx/IkEsE1+LRLu8QF5JuMJOsVRobf6KJRF9fRa1I5azb4oGBkFmOMGqclGItxIyPD5Wu
	u5/TiWw==
X-Received: from pfua29.prod.google.com ([2002:a05:6a00:11dd:b0:837:a076:d251])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a96:b0:82f:6cb3:645a
 with SMTP id d2e1a72fcca58-8414b5956bemr21117260b3a.31.1779895224781; Wed, 27
 May 2026 08:20:24 -0700 (PDT)
Date: Wed, 27 May 2026 08:20:24 -0700
In-Reply-To: <eca019cb-142d-4933-8273-0607dd900565@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-3-chenyi.qiang@intel.com> <a479bef3-f24a-458d-ab90-3216712e1fcb@intel.com>
 <d08b2f6f-b2f1-4cd3-a1fe-588261e3ee10@intel.com> <ahcGpKXNHOxMKNTo@google.com>
 <eca019cb-142d-4933-8273-0607dd900565@intel.com>
Message-ID: <ahcLuHLCyk3DPFOU@google.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] nVMX: Validate DEBUGCTLMSR_BUS_LOCK_DETECT
 states during VMX transitions
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026, Xiaoyao Li wrote:
> On 5/27/2026 10:58 PM, Sean Christopherson wrote:
> > On Wed, May 27, 2026, Chenyi Qiang wrote:
> > > On 5/26/2026 8:32 PM, Xiaoyao Li wrote:
> > > > On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
> > > > > diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> > > > > index 48835eba..c8426770 100644
> > > > > --- a/x86/unittests.cfg
> > > > > +++ b/x86/unittests.cfg
> > > > > @@ -471,6 +471,14 @@ arch =3D x86_64
> > > > >  =C2=A0 groups =3D vmx
> > > > >  =C2=A0 timeout =3D 240
> > > > >  =C2=A0 +[vmx_bus_lock_detect_test]
> > > > > +file =3D vmx.flat
> > > > > +test_args =3D "vmx_bus_lock_detect_test"
> > > > > +qemu_params =3D -cpu max,+vmx
> > > > > +arch =3D x86_64
> > > > > +groups =3D vmx
> > > > > +timeout =3D 240
> >=20
> > Why does this need a separate config, and with a massive timeout?  This=
 should
> > be nearly instantaneous, no?
> >=20
> > Ugh, because you copy+pasted vmx_cet.  That thing doesn't need to exist=
, the
> > testcase is run by the common "vmx" entry.  I'll send a patch to drop v=
mx_cet.
>=20
> I told Chenyi that to actually be able to test LBR bit, we might need som=
e
> specific QEMU configuration to enable PMU and legacy LBR and it will need=
 a
> specific config.

Ah.  AFAICT, it's just the migratable=3Dno thing?  If so, any reason we can=
't do
that for the main "vmx" testcase?

diff --git x86/unittests.cfg x86/unittests.cfg
index 48835eba..fad58255 100644
--- x86/unittests.cfg
+++ x86/unittests.cfg
@@ -320,7 +320,7 @@ qemu_params =3D -cpu max,host-phys-bits
 [vmx]
 file =3D vmx.flat
 test_args =3D "-exit_monitor_from_l2_test -ept_access* -vmx_smp* -vmx_vmcs=
_shadow_test -atomic_switch_overflow_msrs_test -vmx_init_signal_test -vmx_a=
pic_passthrough_tpr_threshold_test -apic_reg_virt_test -virt_x2apic_mode_te=
st -vmx_pf_exception_test -vmx_pf_exception_forced_emulation_test -vmx_pf_n=
o_vpid_test -vmx_pf_invvpid_test -vmx_pf_vpid_test -vmx_basic_vid_test -vmx=
_eoi_virt_test -vmx_posted_interrupts_test"
-qemu_params =3D -cpu max,+vmx
+qemu_params =3D -cpu max,migratable=3Dno,+vmx
 arch =3D x86_64
 groups =3D vmx
