Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543557;
	b=O8scLu8L2zRmC//ALG1XI5NyN0hj4phoXbcUqDO9ZRK0bQs/w8vPqZ081YRAdmh0+RpS
	 VWs/xAHQlaCAbTn1fzJWh4/sZPNus/UGGB7+TgOh2AwE/9nTGJs0DmznFhd9X4/xLdTem
	 FplWvzRrvrAQM4EdAypMRM1YOMlRj6XDwdnOJd0HqLAgTE0oVhBF6DIA2hHGalAZwsS9x
	 2amOebUP49pgOQ+e4VWU4xTyNQ7YE4+nBK0aHZpwLhWycARXLzQ2flkh62u5mJtctJgEr
	 wlQbnVWxP/0ff//sJx5MTWwFuuFfevCw8wf4EZFaxS/BgLKuQXbIvcgln7thW1zkDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543557;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=aBPFZif7OQNjM5QKYDwZZgIncRfMVh/lXXAldLLFMNQ=;
	b=3y3iGqZDyJ/71UAzPSsh/Pt6jqP8Wh95sfl1u0TEP/yyQQi5og/JiOx3nju6CwjkRpi5
	 Mc7H8TS1hzCq1afes/LxaVzXoI/7QbFLQ7JgmlVjtkco+qKaIu6Uhcljf0YCGaZmxgcJR
	 A274U7V+PqjTNvhkcnuVbKQDEq5XEacyDHs0t1wzvScCuOViu96A6um3Ylsv7mRfnqauC
	 3Ot4L8V1Won1z4/m6k7xcPE3XHl8DXiv79d2/4a/x7+NYHckNo1UAjndG7N4mmrjMUU2d
	 9y0CBgiNVviZCWBiVk1jcp3I8MVo6mPAhqDg1xGvKtf+6XY/ykNYpOTuJLiEmciCanQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsDnhleG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nb0IoGMY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04397606A33C
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 18:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04397606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsDnhleG;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nb0IoGMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795543554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBPFZif7OQNjM5QKYDwZZgIncRfMVh/lXXAldLLFMNQ=;
	b=fsDnhleGBU82AOEnmOdRrLo08bW4ojSBwKFAOJxtBsjpXZim0JywgFck8ob0DVkufDLRYC
	CHK6JdKCQvh5MnMLV0UR4N2tZkHEAdLCd1nx3NLxgCbUhQlznOVzAqzjIUDazxUdQ3r7nR
	7cgjvweM0gMib3itRkweJBEEUE2kT5o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-W9VhOKlFOgmtkh6Kud8a6Q-1; Tue, 24 Nov 2026 18:05:52 +0000
X-MC-Unique: W9VhOKlFOgmtkh6Kud8a6Q-1
X-Mimecast-MFC-AGG-ID: W9VhOKlFOgmtkh6Kud8a6Q_1795543552
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d994579f9so42822821cf.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795543552; x=1796148352; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aBPFZif7OQNjM5QKYDwZZgIncRfMVh/lXXAldLLFMNQ=;
        b=nb0IoGMYCcsrH8uMOgyGr56uGvgT4Iei90t0DcOG1q5we5yevXR7yggGoCmtlMsiI7
         gyBUjrDIA0XetdqmJ1Fx45gCtpUSDfNgze70fLYOfAewfE1NjyiVnCYrEZevN+UBR+x4
         CKImMWVJYa44H9esz/QSeF8W/kmXV8W4WQlropAZnIJ6TCaKNnM327+QZLEIs0tFR96w
         +/yjO5ByYNV6RQZEUVleLSaOODFh3cdnyA7a8JUwzVI5LmvkLanyLDvCSdlIKPSpacNp
         VZU7FaRo6KVDdYXHw1sh06Do+kWTVvy3uLsEb7jyUK2NXJhyN9jOErYsUjP1nVzGTTdQ
         ykLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543552; x=1796148352;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBPFZif7OQNjM5QKYDwZZgIncRfMVh/lXXAldLLFMNQ=;
        b=hQSG01PWQttSALzr6YcVBnP2PPXHtR1SIrRPVVM5n0e+2Lle67AuXTk1to32F4NQu0
         0gyEpqcVnG5k9hrMAp77Nj4OgOFo6YWw5YYOItR8bDzMH1HnlQesMCZkaONX1xbjJjP+
         Pm6TogTy8gCgnklFG/Sf33xrmK9cLX+KnWrf9Hujs2xIN4r11MC8b3APA9eIKiVIy7Sd
         vAMJycMouuBzWydL7AUTDv2sG7Hmjx9p4sQ2gJx0OjisJRpSL90ZIhJyLy1DQ8r+r0ut
         eggFteLRrVDwnoG/TX2D9Ow0kEmaZFu+BATXIwp0yivK5a4UBVToVReOJVBDJCxMjug/
         KLyA==
X-Forwarded-Encrypted: i=1; AL+hErGs0n0BAMXq/VROXVv9CaMHzIBRpFW5pIwDZPpElcqEWeHM5cucOrWwCqBq6bd81t/pyrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xYo30jsARzGUuHorPrES9lJoevcWfS+4RkwiKl+DOLRQLc925
	yEWUXV2YypYYHnPxUU6JOf6iAoFKPrRTb3p6aF1zoZ7IY1wBGo0cJMim7Mae+5zWOqEgYzpS9ni
	iny7RuYEuyJNPp872r6RVW7cHbi/KvpizSFqqEhIco54HknvYjZYriZfuQ8pPSw==
X-Gm-Gg: AZFdTZeqBbbUKeuJTAgJBzK0tAyUgNMjZDnmR7f5sH0TK/X3E78/3a+Mysh/xFUkEkH
	RJXdD65np6EoMuluLWCiAi6IZARDQM6VUwJ2lTFzDRxnfpAakg7WWuX48v9gAA6YUxBx0SUny2p
	ygRAvxiXh5sq7wPAV1rvyHk3xhG8Vk9jq3MJn0GP45BEfVq7KEz1iOHaz98yYWh3KEc5OTbMw0R
	ap31VVSfjze6rNHOvG4EPEE8AV2C5jsbhQ8pMDk+hqbQBEKM6VMQYmjN++9BBwVUA/pmtIDBDAW
	y94N6Xr4ykWhqP9MaDpXtiqFgYWW1RMSKbDB5vPgNBIJ5cyk5jngV8qW2i+LBr/flxmDxjc5Ljd
	8GFGTadQrjlbhdY+8poULC9RRcMG1kDaz2KMR6wQGyTqCNWBlp7j1MB6eL3h4k5okEvSEbx3RXO
	M8QHW9cRQ=
X-Received: by 2002:a05:622a:1b23:b0:533:920d:7bf8 with SMTP id d75a77b69052e-55d76a16dc4mr294519471cf.24.1795543551688;
        Tue, 24 Nov 2026 10:05:51 -0800 (PST)
X-Received: by 2002:a05:620a:371d:b0:93f:3e39:efa1 with SMTP id af79cd13be357-949ba9c6d0fmr2938776385a.23.1795543224025;
        Tue, 24 Nov 2026 10:00:24 -0800 (PST)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb ([209.103.33.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb427388sm1088866085a.42.2026.11.24.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:00:23 -0800 (PST)
Message-ID: <d699e5865a19a199d9044d815d3428a74c46f6c8.camel@redhat.com>
Subject: Re: [PATCH v3 5/5] KVM: x86: nVMX: fix races in delivery of nested
 posted interrupts
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Date: Tue, 24 Nov 2026 13:00:22 -0500
In-Reply-To: <sashiko-outbox-229799@kernel.org>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
	 <20261123175512.80438-6-mlevitsk@redhat.com>
	 <sashiko-outbox-229799@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 18:19 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] KVM: nVMX: unhandled error and unmapped state in
> =C2=A0 __nested_vmx_vmexit() PI completion
> --
>=20
> commit daa28df8cd412bbb1c1a76b22827fb7d30241474
> Author: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> KVM: x86: nVMX: fix races in delivery of nested posted interrupts
>=20
> This commit synchronizes nested posted interrupt delivery with nested
> VM-Exit using atomic operations on vcpu->arch.nested_guest_state and
> processes pending nested posted interrupts in __nested_vmx_vmexit().
>=20
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 61f50175ecb79..845825c018bf5 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> [ ... ]
> > @@ -5122,7 +5128,13 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, =
u32 vm_exit_reason,
> > =C2=A0	if (enable_ept && is_pae_paging(vcpu))
> > =C2=A0		vmx_ept_load_pdptrs(vcpu);
> > =C2=A0
> > -	leave_guest_mode(vcpu);
> > +	old_nested_state =3D leave_guest_mode(vcpu);
> > +
> > +	/* pairs with implicit memory barrier in vmx_deliver_nested_posted_in=
terrupt */
> > +	smp_mb__after_atomic();
> > +
> > +	if (old_nested_state & KVM_NESTED_PI_PENDING)
> > +		__vmx_complete_nested_posted_interrupt(vcpu);
> > =C2=A0
> > =C2=A0	if (nested_cpu_has_preemption_timer(vmcs12))
> > =C2=A0		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
>=20
> [Severity: High]
> What happens when __vmx_complete_nested_posted_interrupt() fails or runs
> before vmcs12 pages are mapped?
>=20
> If L1 configures an unbacked or MMIO GPA for posted_intr_desc_addr or
> virtual_apic_page_addr, vmx->nested.pi_desc or virtual_apic_map.hva is NU=
LL.
> __vmx_complete_nested_posted_interrupt() then calls
> kvm_handle_memory_failure(), setting vcpu->run->exit_reason to
> KVM_EXIT_INTERNAL_ERROR and returning -ENXIO.=C2=A0 Because __nested_vmx_=
vmexit()
> ignores the return value, callers such as nested_vmx_reflect_vmexit() and
> vmx_check_nested_events() continue running L1 in-kernel instead of exitin=
g
> to userspace, while non-KVM_RUN callers via vmx_leave_nested() clobber
> vcpu->run->exit_reason.
>=20
> In addition, when entering L2 with from_vmentry =3D=3D false (KVM_SET_NES=
TED_STATE
> or RSM), nested_vmx_enter_non_root_mode() defers nested_get_vmcs12_pages(=
)
> via KVM_REQ_GET_NESTED_STATE_PAGES while publishing KVM_NESTED_PI_ACTIVE =
in
> vcpu->arch.nested_guest_state.=C2=A0 If a nested posted interrupt arrives=
 and an
> L2->L1 exit happens before the first L2 entry, __nested_vmx_vmexit() clea=
rs
> KVM_REQ_GET_NESTED_STATE_PAGES without mapping pi_desc, so
> __vmx_complete_nested_posted_interrupt() drops the interrupt and triggers=
 a
> spurious KVM_EXIT_INTERNAL_ERROR.
>=20
> Finally, running __vmx_complete_nested_posted_interrupt() when vmx->fail =
is
> true clears pi_desc->on and writes max_irr into vmcs02 GUEST_INTR_STATUS,
> which is then lost because sync_vmcs02_to_vmcs12() is skipped on vmx->fai=
l.


Technically KVM doesn't have to fail when nested PIR and/or nested APICv pa=
ge are MMIO, as stated here:

KVM: nVMX: Fail on MMIO completion for nested posted interrupts

When the kernel has no mapping for the vmcs02 virtual APIC page,
userspace MMIO completion is necessary to process nested posted
interrupts. This is not a configuration that KVM supports. Rather than
silently ignoring the problem, try to exit to userspace with
KVM_INTERNAL_ERROR.

Note that the event that triggers this error is consumed as a
side-effect of a call to kvm_check_nested_events. On some paths
(notably through kvm_vcpu_check_block), the error is dropped. In any
case, this is an incremental improvement over always ignoring the
error.

Signed-off-by: Jim Mattson <jmattson@google.com>
Message-Id: <20210604172611.281819-7-jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>



To avoid the complexity of bubbling up this error from __nested_vmx_vmexit,=
 I will move the kvm_handle_memory_failure
to vmx_complete_nested_posted_interrupt, and only note the error with the r=
eturn value in the __vmx_complete_nested_posted_interrupt,
which __vmx_complete_nested_posted_interrupt will continue to ignore.

If the guest setup one of the structures in the MMIO, it will fail sooner o=
r later anyway.

Best regards,
	Maxim Levitsky

