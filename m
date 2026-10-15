Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78B4ED186
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055791; cv=pass; b=Y3R/nlKEDk3s8ZpGsFfhFTs01uZIvy9IpvBxbMBbJr+s65PrqS6TV0HhD73Dk2uXlj9z9J3VPWjpzeY9kh/kwUW3mD8UPuPZfDpY4ViXqp4c+wk+l0YvLSS9/6/M4uuQbzDn9r3gVuXzIWkPhdwR+yC2kYuk+8/Xa6BCXAIo//A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055791; c=relaxed/simple;
	bh=Ipa/IDF0CONphFufrDn6odjM7p/ev2Ux5p7STQvynxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjcYIz4CZfgGFl4WLAXMk1WS84AWAJr52SZb66bBozkKLWtO3K7LH23jdS+NcmZlZ3pMp4S4hU9amMiGq/a/mV5NQY4TfyzJPcq80sM4fXTwbWxUcsDMTNjxx3am6W+WwEms2jf4wlVir0AXcZdILOwT4k3MJEKCGD5S4xN8nWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJ/Xkoyk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t0e7NJk+; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ/Xkoyk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t0e7NJk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792055787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5fPgirNcjNimepZTvB5AtXWg/xRGRxyRHFM6E7rGoY=;
	b=QJ/XkoykmWWJ7f9ogqdhZHdZFM274xdMKYn4ar45qUq37kMbYslZlvkLhHrYijX8C4iEOW
	RLUPNFCvdPwaDVH1A9r4z6MMLLldIvj6cNGdWlaq6F9d8+vKlwdvYCbz7NAUQp9Uo3ep+i
	jBM+35dsC4G7BoPRxVavwt07nQlQdfg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-TbLDcUhmMzSiF94H6vqE8w-1; Thu, 15 Oct 2026 09:16:25 +0000
X-MC-Unique: TbLDcUhmMzSiF94H6vqE8w-1
X-Mimecast-MFC-AGG-ID: TbLDcUhmMzSiF94H6vqE8w_1792055784
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso38132025e9.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 02:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792055784; cv=none;
        d=google.com; s=arc-20260327;
        b=HuqNpncxEU/ihhtQ7YCo4hqwLg6V2Cf+mkiAWXBPfdEMBk8T+q0GF9QVhqpIg5ikVL
         DmitoRvlr8ojmJURFn4N4zaV7nwQoHYyRxgwlovk5OSf2CjDP0n6OIW3a6B9Oy65ZR9M
         U8dX/aen9YJ20IYS3Gx3hJ+6Hk9HknrjClv00KySc315bxeyJ6zaUaEsth2DHQ5WSFS3
         i8tU44rDVaAyIkgkrBcbyU/kQlwiuxwkSWq0vEFPoTo9BUOZFfnoT7GbkdTvYRtykfcm
         JgxQIw8rOuVkoOTSpS2VEWhfhK9zNScF5f4zqCvNf7F57OsRZCc4fPbZf5zth6ZsXugp
         hhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5fPgirNcjNimepZTvB5AtXWg/xRGRxyRHFM6E7rGoY=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=TV/cjuGOzrkpMyP4bELeeltf4BVWEh119jMG5a9sXr2LfDwLYGca8VK89+bBSA3WJS
         f5jqmQ2L3lcdiSnl8Qxo+n92r6Y41lvHzSVuuNKtocS6gPZ3Zqp1HXbDhX7aJp17r187
         mbBWNc1SmGp6t3eIrHNriY7NQWDklbA3S7SYhlRonLdJQ0upSmkia2f5Nk4D8Bu+qqE9
         nFAZgV2bPYHQG9j+EypQWBbBD6t33oVMko6IURZ2pqzdnl7zaXGyFYdkRvv2tI1ynpd3
         jMrI3B0BhYF4yg4WKB9FEjtzXvsZyjwNRuJVnOcHZsBEAl1Op8/qLSybwXo9lpoBfixs
         Mw1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792055784; x=1792660584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5fPgirNcjNimepZTvB5AtXWg/xRGRxyRHFM6E7rGoY=;
        b=t0e7NJk++crcL9p8ibpmbvJX1WmjCWp9CzbPAQAvo/cSHrASNSgoGfI1p+bz6Zqme1
         A/92/H5cCcwwBmjZ6fSHSoCtgT3uPoBJLztQ9SnRgVGyrEQ5oZXcniOTRAZsSgZQsYm5
         VNkuE0q0FVl5Mc/VrQhRQgJIFbfMn53di2Q9khoa1Pv6CQuaI+aqHVJ6JNfbTuMCoV0+
         tJYYYUuOKt/lqkW+pTrvNhuppASRVLZYbxjiG5eInKgU43ue7MgAljfxJ+LhBlV0IAhP
         QUBCfBS4nydEnidSmJiN+24/0qKKFtfTDv2FaGzSeewb23m1agldBMs2RyYcEjtr1CH3
         2xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055784; x=1792660584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5fPgirNcjNimepZTvB5AtXWg/xRGRxyRHFM6E7rGoY=;
        b=w1jGv8grOX2lfPFEajZnkQKWHe4RVAS9wSWupIsNga9My7Lv/IVvsNb1E1EHgR2Q49
         uaOgtoFli5hT2SJoamRd8vUyE1IJWyQl9fnMBMOYlJM3M7bp+sGP4Vl16uOlfkQnsx/c
         uLPomWVEE+oAiYTmBXI/J6C3FOldWg2UA1mD9T4jEFf+gyQ11NzOmU3QX5EyeYgRT/Ya
         7ubpWp2dlnAKJ/53nVa+iSJdngvt2sHgT8Y+0/J5DoF8P58DfE8j5GiEzCkHlNpXct4s
         zOGYqjb/sZIdprSDO6OEf2Vmg9QokMBLCcY1kwkTZGVlvCG/NdqLewIOTDXmswER1T1G
         nnxg==
X-Gm-Message-State: AFq9FYJjA6kIjm4FuCYt2om9B8/3XwiPTMI5EMJ6FpE6hj0l1K0GTolK
	oCjZcPeffg/qYrOHdTuqPk3rV1IabdgaSF/KUOJfQrVCsKOUdUp/bc7TsJY/OZCwQLu/Hyd8OH/
	KvKO2Q9R9evs4HLI+mx5UUvxxLSLDW1BHkXk5XE5COLPyWyeo3pXM3/fTyli4dUwxVXOYDONvNq
	/n7iG4P8ta+cigUxbjUX7J2y/jJV1I67lwwBdx
X-Gm-Gg: AYBFou03Kfo0kcprYqIqDssM7R195oJfZbzuGZ4utRNyfoQFzSVA5vba0dSFevdrxrh
	ypps+gk2nqiPMqMGMSJ8Ox6MOzyxIvsIdAbY9disj6KY9nMHcge0l53kEly74VX9eRkFAlBXJc0
	uosH8VJaLC5vEgsvejh/ybrDxmaCeVFRaJ8FkT05zewqR5iZRNv54OmfEo0f5h2D/CGQkm7KMFw
	zxJaFcDnyh8WeQ4AaZ+NDP9M1bFgNV+DjS+y8lqJP5ElRzflt14PurCq/0h7A==
X-Received: by 2002:a05:600d:8499:20b0:4a1:9687:bbd9 with SMTP id 5b1f17b1804b1-4a19687be3dmr229963695e9.35.1792055784174;
        Thu, 15 Oct 2026 02:16:24 -0700 (PDT)
X-Received: by 2002:a05:600d:8499:20b0:4a1:9687:bbd9 with SMTP id
 5b1f17b1804b1-4a19687be3dmr229963375e9.35.1792055783792; Thu, 15 Oct 2026
 02:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015083123.790030-1-pbonzini@redhat.com> <20261015083123.790030-2-pbonzini@redhat.com>
 <sashiko-outbox-172536@kernel.org>
In-Reply-To: <sashiko-outbox-172536@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Oct 2026 11:16:12 +0200
X-Gm-Features: AclHuK-TZpfQTtoNi6gGjWkZn_9BDOy9jJ5Y6zLkjax3ruQERXdVWJNnqbwioxY
Message-ID: <CABgObfboY-O-oKjPCsyfQsVptL7yCse5NcVkXB6itcofahzjGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: nVMX: Reset MMU back to the root MMU if loading
 L2 state fails for !VM-Entry
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:02=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] kvm: vmx: nested state corruption (CR0/CR4/EFER) on KVM_SET_NEST=
ED_STATE failure
> --
>
> commit 55d55918900f4eae4bf7636855cdc83ba4433cf5
> Author: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>
>
> KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !=
VM-Entry
>
> This patch resets the vCPU's MMU pointer back to the root MMU if loading =
L2
> state fails when not coming from VM-Entry. This prevents KVM from hitting
> a NULL pointer dereference when attempting to run L1 with a nested MMU.
>
> Link: https://patch.msgid.link/20261001214356.3825100-2-seanjc@google.com
>
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index b252168627408..5165275128fce 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -3770,8 +3770,10 @@ enum nvmx_vmentry_status nested_vmx_enter_non_ro=
ot_mode(struct kvm_vcpu *vcpu,
> >  vmentry_fail_vmexit:
> >       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> >
> > -     if (!from_vmentry)
> > +     if (!from_vmentry) {
> > +             nested_ept_uninit_mmu_context(vcpu);
>
> [Severity: High]
> When userspace invokes KVM_SET_NESTED_STATE, KVM executes
> vmx_set_nested_state() which calls nested_vmx_enter_non_root_mode() with
> from_vmentry set to false.
>
> This unconditionally calls prepare_vmcs02(), which modifies the vCPU's
> software state (such as cr0, cr4, efer, and tsc_offset) to match the
> nested L2 state.
>
> If prepare_vmcs02() subsequently fails, for example due to an invalid L2
> CR3, it returns an error and jumps to vmentry_fail_vmexit_guest_mode.
>
> While this patch fixes the MMU pointer, since from_vmentry is false, does
> this early return bypass load_vmcs12_host_state() and leave the vCPU's
> software state permanently corrupted with L2's values?

True, but it's pre-existent. And if the ioctl fails userspace is more
or less screwed up anyway.

Paolo

