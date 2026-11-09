Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254570;
	b=NcpEwVo5ADrkSMV+/NQN7RhG7t3AjwkWiavkqLOuKHyv6Gm/DMvl1FIHbRxNUmkjaTbz
	 2cMfVL+dzZSIKSjCYkpkq9oUJeLFnXUJJB909p2i/82k9mc7qsEgmVR5nkYeJKkEha5Je
	 B+67M/FN0ulJWViLDz9m3P8jGmlkNLHnZe0bZSVd/bpecMwGQueJxZ5Nt6vu5o0R5Hp+7
	 CtW8n+aeD+wCmeB23HBlzqh5r2fL5pvOnFpTyNQtDS12oz0YOlUVSGN58VnSw5Ns6BL4X
	 MsOPENG6iWC6h3NEORviIQxZFGzWv0Bm6dh4lYdAYfIpXWpMKN9FXnvQeVlHJHGP5RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=qGRFFPBB1wF37JYd4Ts1/YLImPhgtURF2AZXR3nqT7s=;
	b=Zc7wu7/4k8ipAgMxZ9gbuTkjgIm3chT0ofOA5P9+KuUICKCwAduKj/kp5iu3r0rXBTd/
	 e7dlkMOW1+4GZKsFQSTA0gr7ohhytD8URe3Io1x/yrE9TX+EP9AOpWQHHpwmKkHgeU55A
	 VwUunq5l4c2h2Y+W3E1PWpvVvQIQdrekAPjnhtbTF/rxUnJmbG4QjZUWQ2agCsoOPXaBI
	 YV3gNS0HqCsA9B7idnj1s3kIGv7Q/wpW+ik2cjHj+aCFl6c9KMrt3I29ZJAW+X+c6FeK+
	 mK15l8y8pkx5FLin6Rr2yE+j6WiHorc/0u7+Mco1XfvUkXzXPC4s53GflzxhezN3Ogw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MDVfxjyH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B55606A33F
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B55606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MDVfxjyH
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5e948e56af3so515431e0c.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:02:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254569; cv=none;
        d=google.com; s=arc-20260327;
        b=aNGpkmChJsNNDaqkp8w3pgkfBLvwHgP5Ql4LIPuRZYAE+2TtWzF6VdLTltFVuSNNSf
         Si+qDMLOKO+z1gWCGMKlNcTPjpuvHtx8mqc+sLBqmDw/yfVtIZMpP75bYJwh0yWz5mMA
         rcUAjdqMTH+wbZP4zz/9F9sLP+2K0KwRlZVRBfaz46nsi1DdllJgxRxGIj7UCGdzef4q
         KDJKDmXKkdgJpVdqTe/RLEHsjOhTC+L3NXt4iFAGaRaXNMmt02kk9Eo5pEDnc/LrSNZW
         zcBfoSgqU4z86typ4WT4ppOMDMJb7eNft7KHF24J+Hi9vv/J6Aepk6vP/8dXjxa40LaF
         u7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=qGRFFPBB1wF37JYd4Ts1/YLImPhgtURF2AZXR3nqT7s=;
        fh=E821u0XyiDBwxi2RzejhCwq43hPldgVm4cZi/Kl6uNo=;
        b=o7IbWnPF/94lpL6EDH4trgBU8OunWjwMRp7OJLy2rT00fOLx3VgZ/H2SZ5fgts1ArK
         GONwbMJHrlg4SWgylKaBZscUQyVjFlssRIFwvU5cwTFQUCdh28LEq0coG8Ma4s45yY2M
         O3sAhO+D52Nlzaht7yAaetat+Zk9Clu309hsOOzAJbx8fN5remtetQdx9HT6T7UPZYHc
         aPKql/4Q2PzZJdWPfZ9NWvHO1Es4uzldwzudWcdxDognDuxTx3Hn7QU3pnddtVjAleEO
         GW5ItGRiXg0sRxg7+JizXlVavqL7kKd0LZop+RNUp0I45ykcBHNy1KDIZLArDqdaA4PN
         XBlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794254569; x=1794859369; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGRFFPBB1wF37JYd4Ts1/YLImPhgtURF2AZXR3nqT7s=;
        b=MDVfxjyHJJz7nSVac0/MzxNYBAz0gz5mw1nMRucJC8aUp+/mnDPCU44ZxNDT4hUiYs
         0VO6PuphdsyMx+3xKWYiLk9jOaIwUsbGRkOu0zsaG5mQaDtr2x4nwdguACt/ZWzkD5Zw
         LwYq1XXvp3WJjCiZQPyddb1UADLTSJUEFAooPlzFkNi3lS9+RDyZZ7VAuQXH7AQvz1Of
         0ObyKgznWixBSZh4qMgT3j9WWstoilMA2gS6Kvgh4lHWmYaPSH2nkLlZVxbOEyXYahDe
         7Oxcnxorznvrl/eWoXpjXz8oZ/hixEvnUQqbctYoU7NfzmkCWSo36Kc0RM5K/Bh9cL+5
         qDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254569; x=1794859369;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGRFFPBB1wF37JYd4Ts1/YLImPhgtURF2AZXR3nqT7s=;
        b=BnHYAj+iR+6cn0CUqH/x2Mwt22hDcut0AMsQGKlK8vCEE3gf0Ky65QbBMx/f7Otfz+
         doWmv2wIEnpMubzZ6AR0BpOeGr3AoJHyENgTT6Cn8O7mGPs90eeCHimtYtg59fGjLYRs
         /cRCok+qb6bkYwG6l9ZWjD7kWiwB8bGqvsPRuXCgBLwzH/OR0JXTgjk7tH344hwwRcLS
         l14MdzpilOtYX3eLgbCtHq4BB9i5mehoyIA7LmSvT2BGM2ZVpTE+dATBOAOw+djDrnYd
         BDZFxrFh45oM2HwzjxS5xlS4vY1qsjyGJEzsps1EIOSGzNdwoSM3yMx/784C9uD1sRPY
         bLyA==
X-Forwarded-Encrypted: i=1; AL+hErEUCBnOcqC+LHVFATj8JncpRlihYVW0/zfB1J/LE2mCwyAt4ToCJkhU23FBvENexo+9nak=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FQulax8rGb7y7kmrod9VwD7XQ50LTkQBuceGu1KENtm5jODW8
	mVqATsc6wt0YjQkQPcGx01cAJ2oI7cx1vL6kSe7jp705YuaMvTbULOtD+Fa9jHdLuwIrsnjnR3Z
	+8OMZ/hZ99UY1Jxuj/bMmbzcbAxGxKnDkMC/COn8Y
X-Gm-Gg: AYBFou10c9ToRxQVtnKIftTX/qyQMyHOu5sEhk8AMlELyVqg84RENBIgVkHu4tgjNR/
	uIChzkNoH20aq0eVd2SeMLTjmbdNa9SicfoJk5cDrHKNNKgRznsCmdSy/ZMgbWrIaz6NRVdnmF2
	MqsdNsY2pkIhCeEkgg+1OgIujXfwhRuIWzTi7c6HtnXd91ZWZpUS9TxJxqPgJCaVOVXAuOk9sFs
	LKsSfSAv8sBHOzt3h8tDNEVAwSUDmjWuMiEBUN+QSbUvOZZT3W4BpJgpbVXJf9uHbD2spLq1/eq
	0miFyJJ3hw/1mGR5ZjB3uV0apwwFA6ASElapp2EI7MFb+WSFEj7gl1CwOMFKikkDVpRYclSsxGK
	Tal8eQyOdm69pCdIjQ83WuFp6hqLmzt1/S0I4EW3S9fW4+IyAXSwimJh1JYEN5IK7sQ1NPOJuKq
	Epl3lV3/xJq3QDlIskrqAZEltpRFiPBDQaW1V0y+Ei+r4n
X-Received: by 2002:a05:6122:218b:b0:5ea:b04a:cefd with SMTP id
 71dfb90a1353d-5ee0d0a58a3mr105598e0c.7.1794254568208; Mon, 09 Nov 2026
 12:02:48 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 12:02:47 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-16-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-16-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 12:02:47 -0800
X-Gm-Features: AclHuK93pizTTBvqPPHn8tyB102k3E6xp0ArgfRjiMFhvMMSdBvoYQSIxOQgtlQ
Message-ID: <CAEvNRgGQqdrcLcYbSbiXmFRAHwvGW5Ha_2NPWhMNs-qpnWhZCg@mail.gmail.com>
Subject: Re: [PATCH v16 16/20] KVM: selftests: Load private memory and
 finalize TDX VM in kvm_arch_vm_finalize_vcpus()
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Sagi Shahar <sagis@google.com>
>
> Initialize TDX private memory and finalize the TDX VM after VM and VCPU
> creation.
>
> Hook tdx_load_private_memory() and tdx_vm_finalize() into
> kvm_arch_vm_finalize_vcpus() to avoid the need for every TDX selftest to
> manually load initial private memory and finalize the VM. While this
> prevents TDX selftests that use vm_create() helpers from customizing
> memory before it is locked, no current selftests require this.
>
> In TDX, finalization is a mandatory step to make the TD runnable. It
> also finalizes the MRTD of the VM's initial memory and state, locking
> them in for future attestation and preventing any further modifications.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 11db6a3b0366..ee8a1715d844 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1503,6 +1503,14 @@ bool kvm_arch_has_default_irqchip(void)
>  	return true;
>  }
>
> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
> +{
> +	if (is_tdx_vm(vm)) {
> +		tdx_load_private_memory(vm);
> +		tdx_vm_finalize(vm);
> +	}
> +}
> +
>  void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, gpa_t smram_gpa,
>  		 const void *smi_handler, size_t handler_size)
>  {
>
> --
> 2.56.0.455.g6c5a503b38-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
