Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE01344030
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667915; cv=pass; b=ZLYsr9Eywz+VizjP+MyTfAQmtuCqf07FiK7n2baRWlRqwxl78u+Fx4FdycpTL2Vhx26s7UwBDGJMFnvzczuOPbJzM9GXN0xuYq4nkzm2RMFluQu3sNBSi88O3dke35/Ll6GqeoqCY4ZWkFAqU9MIxTCMYU4T+mmoXksvTVcYfU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667915; c=relaxed/simple;
	bh=VNi24Rd0Up9CVer6FlQvZf4+doC/0e3uwh8unURa9es=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kln+CcbZo1NXhhm+YM81Zy1HuFYfiukdydqsL1iZ2a7Hmx2Cy8EYs/e3DBeMjpNichToc7IBkfZsFt2oFQcFGWYyVAtb/qjLMcLdIrPdYPEehdqOWG2fa+GL0Q4/UizltOgwFoG2aa7qXrZ6YPKD62RpramfMbCdjiBXBYTr6yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFu9vcpF; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFu9vcpF"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13807d2f898so635617c88.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 06:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780667912; cv=none;
        d=google.com; s=arc-20240605;
        b=BuCwLr9EBhEXC8r6UFn7vdXuTt/1Yr7Qg/ZeKm9aUdXwlBu+9DlPd4rpBWPH7hIuWn
         3WSJVksmHOku2tXKms9vzYkKAXsMXFMIRNILvxAXRD21pQ7hgKypTl2X9npy1blj8K+w
         GbSH2cOrgc1pIokiZr6qLyuAIhRq6p+48vwgtZ9UspNeQZ2cUMfAVXIef2Zy+DX5xC/x
         zQ9E/r8jGpbtqnyvLp+HDqWa0q+0lO9gybwjvAMm7qonX6f0ocv0nLh4jpHmHo+MRsdq
         wq5PYjd8Ei9JhBiYEm2AG/EhsbV1/hvszeTbj+waz/e9dW7FdVUyqgl4uMRH+MDsOj+Q
         Xm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=k12kCbIvaHnTqgCGNpO0hMe+zMyl+k4NL8VZ4tGu3Jo=;
        fh=79OkBCbQNSSLFqBZuTO8cIKOG3jAtmjH49A7H2oEonk=;
        b=IiYFbCB6YK+nvfCXZFLTRjDenE0e29tZQfFwLQwM0v6Z5zgTeiRgjv7hX+7oB7GSc8
         aIOMZk0bKN8oASrB7uUb1yoaE2rWZzjH9d0p/JNX7H31HXEts0CJSrEJs21bDeWbcsEt
         wFfxOwXBHfWlWyjY+OsMoSPXZHjyQcuUydLKS/Fa3Eyiv6vGal9jUl8sSoJACgJg9Zly
         em9Y5qHW8QrojBRVhAdwv7oqdLIHBfCxz9CgEGgXVSj4n92cLWqFUJ3EuO+jPH6FxNki
         ecC8fGXTlXK3HTgtLEdEzLu/qM8qgm8PL0oKkiC0SIyrb/HESeGpTUKzd4KxF23oTmDe
         iHoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780667912; x=1781272712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k12kCbIvaHnTqgCGNpO0hMe+zMyl+k4NL8VZ4tGu3Jo=;
        b=eFu9vcpFWK4PcMAPd0uo1Q9KHniDf0z3q2jNWPDx1250Q2T2SDZhuXdz+JWkHxuznO
         npoVVj5fQDpEgE/tKIoDIErMHAi2V4XMVN6SaO9lLFSmDNfeuGe3FRTNEMMAR41sW8xo
         akH0eifRTN2XhzmfQdvatUlGT9Uayt+TFrTkd9ADKUT1/4hFyda/sWTRvx46z2x/GiFD
         0rAGzD4mC1QQTZMUO1wBerkMAl/DHeLZr8xRZKQIcpdydkxmfyui+KKjmJi+/kY27UuF
         dNT0tdnK9Fq7lgPNLTE7Bkg032+vBB9LI2IwtYU4kAIXpV8qtkLCjJxGQ3zaluhaNrJP
         lGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667912; x=1781272712;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k12kCbIvaHnTqgCGNpO0hMe+zMyl+k4NL8VZ4tGu3Jo=;
        b=QdQQSZ6eqOUJuxXTK1l22tvNSrQ9vrRzFzDZM+T7QTi/z67FJS69rrEcgsyoCXz/Js
         BGAw/fGaiQH2HdI285NZ9dG4y1NrKdajFhC3/QRzEihSY7gTKqzGQhELNN1I0Sdgf7Fp
         e+4vxAjlRopvUIEpsdPWXEmyT64UpCfAoFIR3rYK51o1ldrDXUjsJyP4KnMgD909RQFm
         9b0XASsGiPL4nuUAZjHW4PNXfOWnkt4HGI4XDUDOVSaZYnGNeyJRXSB4RQgr2zyXlB0M
         Bk6FdcRH7FQd+wy3YoV+9PTU3vYGySWuudzc/1SoxCuNhX5hfTVjDLXH5Js62MBtJ99C
         6cAw==
X-Forwarded-Encrypted: i=1; AFNElJ+/rMagbpsS9Aly8m1jSNaYupFtyYwtwvxz7pCnjr0ZFWqfSbI2+wRCmu1usDW8zrGeOVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yGjzl3sm/mNkOQn9ydW7I/NpB6lpTWR9BDSM3aTX8sKtQAvM
	zm6MMVkeopHavuJANXY/HIHy6SRsnksefsIWWrovVV5TB960oNHq7HvmKqDW1p6Uk7vRb2eeKnZ
	KKxFFGXE7cxKkuArOUll2vGnSv1+CU7dPM2GIPVdt
X-Gm-Gg: Acq92OGYSWCIxwixg1jl+l+HYNQ1mfA5qL+PuMVkeXTjSpr/XKfdJuzBxArGbMeeqMN
	MehKDNOYLWSexWILFLy/C2LhCJB1hF2u4AIvZzG0QKLaI/iyr5lsw8vjmNLXJqYK14CxOtQAV0t
	5G4cMGDOEomWfAlk/c5vTdqywOtUhYt0jzwCxUz+ynLPI/D2A789afTUnsYxlj/AJnBHS/sKbnY
	SJ4kjyd2jY47cDaxdRuEhvZju6QpEurLu0JUCw95AAvZjcBITYQ2uBhp/t66DOMgFN7a6Xa0+JJ
	XI1/JMlIMuMxOl5gTFmtBOzkmEnJnPDO7grZTe06HRhCjAu5GsqjUL2DIcpo
X-Received: by 2002:a05:7022:797:b0:136:c565:e847 with SMTP id
 a92af1059eb24-1380674955dmr1638284c88.32.1780667911277; Fri, 05 Jun 2026
 06:58:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 06:58:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 06:58:30 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com> <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 06:58:30 -0700
X-Gm-Features: AVHnY4IxXSl09mthH0pIzdFqFex4dXIrMh3HcKKHB6asWNozDxLWNfOIVIJk5qc
Message-ID: <CAEvNRgHEq-hHcTivUw8TYBeMu-RpS=Ho4DXaNXKQKLPL_biTgg@mail.gmail.com>
Subject: Re: [PATCH v13 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Sagi Shahar <sagis@google.com>
>
> Finalize TDX VM after creation to make it runnable.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index d84c629a1945..842cac168e99 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -1479,6 +1479,12 @@ bool kvm_arch_has_default_irqchip(void)
>  	return true;
>  }
>
> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
> +{
> +	if (is_tdx_vm(vm))
> +		tdx_vm_finalize(vm);
> +}
> +

This doesn't necessarily block this series, we could (re)move this
later: I'm not sure if kvm_arch_vm_finalize_vcpus() is the correct place
to be finalizing the VM.

Was kvm_arch_vm_finalize_vcpus() supposed to be for finalizing vCPUs
instead?

The awkward part is that kvm_arch_vm_finalize_vcpus() is called from
__vm_create_with_vcpus().

While building this POC to test conversions [1] I only wanted to create
the vm and vcpus and didn't want to finalize yet, since I still needed
to do more mappings in the guest (and I needed the vm pointer to do
mappings in the guest).

Would calling tdx_vm_finalize() from within vcpu_run(), just once, be
too magical?

It's also possible to have some kvm_vm_finalize() call that can be
explicitly and manually invoked from selftests just for CoCo selftests.

[1] https://lore.kernel.org/all/20260605134153.204152-1-ackerleytng@google.com/

>  void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
>  		 const void *smi_handler, size_t handler_size)
>  {
>
> --
> 2.54.0.746.g67dd491aae-goog
