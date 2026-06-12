Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71B2F28FC
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277453; cv=none; b=tdGw/37eXJSw4JUCUw1ATL1Gg/aINyqktsBJlbSEKIZlGZIFhJXML7JLHhna3bWRVqzSK8JSVIGwrdVp6/tHUExTjJ9aBaD1fcag0XJCjlQS9/9tgc8OqVWtQ6468EYjhoyRyiJ2j2t8s8PTAungAUxq+sBeX9cxqySgYju+Lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277453; c=relaxed/simple;
	bh=YGzz9U5ptAN+fJtxvPnrBajIVB0+7ihNMtCDsAQmleU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GtwiSG43uHMiiqwFYwqMSHIpzf0LxvZfT8iectJ+cfH+97cwhI7pb9knen9IJBUh8/0yLmojFzcjAetlOeWS69GOmEhbQux7OqegxTwiK+ypgnFCXd5YymWsrudeokfY8EWOSveb5tjX2E/z+InEzVae5o8yh7IA8u9HkkEdoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3TC/XdO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3TC/XdO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3315c5dso11400245ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781277452; x=1781882252; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKi6voXMiSHRHdUtGCaL73/GFSuif8U6u8yo1gqGgaw=;
        b=V3TC/XdONPkSMS+lgesKaCdZkj6lBs/eBCXYEBXiWEpGOKVv4jFS/MB+xgO6zijWAS
         HpTtOy8Pu4Qf+/Msrh9P0XKA6kfAb0T0vqylWrUqdwyIqw+XbOJWhER9i8NJs6p1m3hH
         umARVSukOTRhFM1vQUQXgPAIrCDif4d8ETnZoCzozCd6LQPFL3tIUDCyaIEDQhAVXyDj
         4mQDQVDCXHYc4vI4iafdv9H2SW4jY53/4YIv4yJb4HQmBtmwsMfrEEVEAoAQ0y8Nidf0
         uKHEty5QWE6R6MADwGz+gqhF2beOWvpFCzhk7YHg8BvgOmyj+IBOymB3+imN6W2+XYkJ
         fGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277452; x=1781882252;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKi6voXMiSHRHdUtGCaL73/GFSuif8U6u8yo1gqGgaw=;
        b=cXbNk9r9hy5gKZ0vNVXaX4u/ac6DCL1tnPrL4tpBGkfm2XZYoAnczP3HRFsRa8dBvF
         bAmOmuBYCYsmE+qk/a076jRFiusnQn/J4RaUrwnQYFJw4uJPPxaFA4KD0l6MfGFZi5pL
         ZvUHJVDDzOwTESs9RuK+Jw7yyZlmwWYX2gGTSOwXpU9kYJUrxzRt0ma8B7jyDbvB3hSY
         OzEISmOQd53c7367mxKAZQCCzM1BK4guf6Ng6WbNc7hBUGrsN2EZRoc2V6fFFy5EX4Ej
         ps5ruSh6zN1YsNHiRMIsRaPJVOHXhyUh7GukBJ/vNqARGo5KM4Ye2RRWRJdOaYz13UqO
         tx+g==
X-Gm-Message-State: AOJu0YyRe4z9mWFgJNNnUn/r75Z0F7w+/M8g3k9epAjp+z6SIg0PtQXm
	hOMrygjDSvWg6zvTJrAJ47Ao20t37mumjRa3kZPtf/IMt4s140RKXU5h
X-Gm-Gg: Acq92OH8ImdUTDIid0jscfFPhI3m/T3nnFgVQylwYS1D+6acDX6iPCNJtl2QTgUm0NS
	z+sMxsHvMA5ySGG8ALg8LpxLQQgujdILb0Yvaz3v6QMt+vt70MshlAYt+5nYDsP6EXwWcAysE/q
	hBmjzrRRi0yS+a61xFwOHC7DWS8syvijVfBvxHGd+xEjBDbwQnTqTYbvr3/JUZEjZS+30J5Aov0
	4iyKmPAbNj8woJHAZS3r7n/8rkmKCtZpjkaulO5ta+fjthkVSFm6UqgtU/0yoYk8j+NUbe4WMoB
	rWFDfvGphC+6/nAybrJbB/1Gyk4wn4U9xv/KCxDq+FjAc360R2MYZPOFJ8/2PPnQm/5qZhZUAhA
	bJgYRBEpO4gZGJ0TZNipt0TnDbKxcIHDLe1t6UDxeYDN2MWCIE+cGZKd8LVAanNjPr/WpYxHLOU
	TdBXsyzX3zOuQwmXUs0JJObTvtzA==
X-Received: by 2002:a17:903:2285:b0:2c0:db23:4a4 with SMTP id d9443c01a7336-2c412d25493mr38857585ad.36.1781277452015;
        Fri, 12 Jun 2026 08:17:32 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm26390065ad.38.2026.06.12.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:17:31 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
In-Reply-To: <aiwd_8Jj34IH-pFH@google.com>
Date: Fri, 12 Jun 2026 20:44:17 +0530
Message-ID: <fr2reqpi.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com> <aiml9iB_vUASRRQV@google.com> <ik7nexem.ritesh.list@gmail.com> <aiwd_8Jj34IH-pFH@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jun 12, 2026, Ritesh Harjani wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> >> From: Nicholas Piggin <npiggin@gmail.com>
>> >> 
>> >> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
>> >> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
>> >> VM's limit.
>> >> 
>> >> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
>> >> to the kvm_create_max_vcpus test case to limit vCPU IDs to
>> >> KVM_CAP_MAX_VCPUS on powerpc.
>> >
>> > How is this not a KVM bug?  Literally the reason this test exists is to validate
>> > KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.
>> 
>> It's not a KVM bug, it's expected on PowerPC. On PowerPC, vCPU ID encodes SMT topology, e.g. on P9,
>> vcpu id = core * stride + thread,
>>   .. where the stride is same as kvm->arch.emul_smt_mode (VM's emulated SMT mode)
>> 
>> So the vcpu ID space can be sparse, however KVM_CAP_MAX_VCPU_ID is the
>> absolute ceil value (MAX_SMT_THREADS * KVM_MAX_VCORES) i.e. the value
>> with the maximum stride / SMT value.
>> 
>> Since default selftest VM uses stride 1, so it rejects IDS >= max_vcpus.
>> 
>> e.g.
>> static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
>> ...
>> 		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
>> 			pr_devel("KVM: VCPU ID too high\n");
>> 			core = KVM_MAX_VCORES;              /* rejected case */
>> 		} else {
>> 
>> So, it's expected on PowerPC. vcpus with higher IDs can be created but
>> for that we need to set KVM_CAP_PPC_SMT and use strided (sparse) IDs.
>> But since the test as of now is not doing that - that's the reason why
>> the patch only allows to test max vcpu IDs upto max vcpus.
>> 
>> But I guess you must be hating the #ifdef __powerpc__ there. I agree I
>> don't like it either.. maybe we can do it this way?
>
> I don't love the #ifdef, but it's more that I didn't want to effectively skip a
> test because KVM was reporting bad information.  But after peeking at KVM_CAP_PPC_SMT,
> I 100% agree we don't want to deal with that here.
>
>> -#ifdef __powerpc64__
>>         /*
>> -        * powerpc has a particular format for the vcpu ID that depends on
>> -        * the guest SMT mode, and the max ID cap is too large for non-SMT
>> -        * modes, where the maximum ID is the same as the maximum vCPUs.
>> +        * Some architectures (e.g. powerpc) encode topology into the vCPU ID,
>> +        * so a default VM can't necessarily use the full advertised ID range.
>> +        * Let the arch limit the highest ID this test will create.
>>          */
>> -       kvm_max_vcpu_id = kvm_max_vcpus;
>> -#endif
>> +       kvm_max_vcpu_id = kvm_arch_vcpu_id_limit(kvm_max_vcpus, kvm_max_vcpu_id);
>> 
>> 
>> And then in kvm_util.c -
>> +
>> +__weak int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
>> +{
>> +       return vcpu_id_max;
>> +}
>
> What if we do this?  We're going to be bleeding PPC details into the test no
> matter what, adding an arch hooks just seems like extra cruft and an unnecessary
> layer of indirection.
>
> 	/*
> 	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
> 	 * which case system topology is encoded into the vCPU ID, and so a VM
> 	 * can't use the full advertised vCPU ID range without crafting a valid
> 	 * platform specific topology.
> 	 */
> 	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
> 		test_vcpu_creation(
> 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);

Thanks! That should do and I think that's the most cleaner version.

I will change patch-4 with your suggested changes then.

-ritesh
