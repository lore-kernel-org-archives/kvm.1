Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413446;
	b=2Z6webIMdi/qh1n7wJC7OTjeSu9hBEnrpGiWZKQcFFm9ZF1Yj2fgD61ddMSQmthlPn6/
	 8DxUGmaL01JScwQ930z3BbfRpYdf8ljLs3EE0cc3ozDqZTuPRzRaBYO6pXgY/bcQ3Jrpj
	 rSlVae834/NpQeGo2sKdVAojYb8IHw7Er/9KwdhDKV8V5kHs4OTm5SZJG7+jJm5nFBIyE
	 QrZwTwFgHAmrP5yVM9h2oemDdgtckF78ZImI6zK4Nlb2FS4V53j2HS4w8NtalrA9CqR2W
	 /s+gvox0wfXEpWaJI9aKAVr3OkExtvZOrPGetVRK2FzpSPvWyVi8dG+Jd+a8nE6v+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/fQfvN//SsC5kV/BzNX6zgi6Mg1pRUnE62HeFEaVagc=;
	b=bi/Eg/Yh2WIAUZ+u3HGTJWBiztpBV91gjBTNoZLCPykadw0HL/v/6vVJdrv9toIZ1CAZ
	 N1rlDKDIVjtcU92UGavXH6A/2vtYDPxMWRnkPN+QQ3zVuRjgpNth/ik1R6vCRrnHEop1P
	 AnNoNZDvu//MiN4JR749ERRUNi9OUZRv/mgvhXveqizW4kCqbbyV/IIfJA0/04ALxWlZ2
	 +njJmk5RW78O9gtvQ9ZlbpWZ7NcPPX2Up9vckA2sfeSP+5LzrZPAwVaLRcNlsSt2Oshra
	 VFGqVbJpBSpmw699ybuFFhPU6BQj6FVSiypSFgvAMzEsg+yf5+ojke6jDFXsa4tLSKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V9OfH5IJ;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B61606A337
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B61606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V9OfH5IJ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so4127469a91.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794413446; x=1795018246; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/fQfvN//SsC5kV/BzNX6zgi6Mg1pRUnE62HeFEaVagc=;
        b=V9OfH5IJti8IaVMsGoGROmRICksQAWzg5oySMiDPT3HFdwJeZaGbgLepEbyWICtY/z
         ASPtpqwLTqrU36T4NSMfOERJsgOYJFYH98JqtSK1vClQSq4oX1XlXhEq+XCq4cPEMwlI
         fkyCwFHqvv0gRYfSZFXY9EHnG44ZeTZBKqPPoQDDX99WL+mbTJ16idpMqrxARh8SVzN4
         IA1aUvA2GcXJKmXeZcUNBrMQSwRPD7h6dgj0fJdX2qV11cp7ZEUYpTUmUmkurs7FH/jP
         IKlpzd9jBXwPxkum5RtHQuh9di1FuRJ0Tnw4GUxuMVQCMElmKeaSU4n4282VsI9zpCq0
         vbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413446; x=1795018246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/fQfvN//SsC5kV/BzNX6zgi6Mg1pRUnE62HeFEaVagc=;
        b=NesliitdkQW2KYmu6F/LnTv1Bz+1d1wcA9hDugTwN5UGGRzRlU4fS+Zr0vrfyoURai
         tYZMyzluJHo6TZrYgLV8srk8vQu956Vfi20ur5KY6T87ofi4zWa0W07N7GtKd7iVC5Vc
         kd6K4g/g73lUKPhkKPRX5SGjX7Fuh+GTsxcERSIW1dAFDexbH/OfbelPtZBXf6uF4P/n
         DnSfEAxIuj47MHFE39CtnhK0eNzIgIbyFgXHoShYAQJ0GDOzfH7lBmJLmYPj+I0yJ56V
         rdvgHp8FL/9T6iFlNXOJhFJ8S7oWfG3M/8/oVCR7DGotutPh2eXrG9kOqEChdipnj1M2
         5LVw==
X-Forwarded-Encrypted: i=1; AL+hErFkCDB3BConZYY09fKvheoMoaXo/eijsVA1CIMLmOWpPcx4VyLUzIXEX5KUF/TPqeYAga8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XmoP3KspmUv99dzqQ0XTyTU/xH1jyX8XEyBvwKpFF62zq7qf/
	z51ggTAe4Gw/g3V+1y8zTB3Td1UH/4KQix/memI97RlOYkq0FmgF05gVy1yf4hCTxYBWE0/c0MZ
	gJrYyjA==
X-Received: from pjbkn15.prod.google.com ([2002:a17:90b:480f:b0:3ae:b67:263])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f86:b0:39e:6c68:c77a
 with SMTP id 98e67ed59e1d1-3b182f2699emr2883420a91.48.1794413445538; Wed, 11
 Nov 2026 08:10:45 -0800 (PST)
Date: Wed, 11 Nov 2026 08:10:44 -0800
In-Reply-To: <833af78b-60b9-4031-88e0-555363f8dd0b@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-12-2024e8fa517a@google.com> <833af78b-60b9-4031-88e0-555363f8dd0b@intel.com>
Message-ID: <avSThO-PZPrIfT5g@seanjc-mac.roam.internal>
Subject: Re: [PATCH v16 12/20] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <iweiny@kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Xiaoyao Li wrote:
> On 11/6/2026 7:46 AM, Lisa Wang wrote:
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > index 4330290d29e9..9d951f67b3b5 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -46,9 +46,31 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
> >  		    #cmd, ret, errno, strerror(errno), hw_error);	\
> >  })
> >  
> > +#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
> > +({									\
> > +	union {								\
> > +		struct kvm_tdx_cmd c;					\
> > +		unsigned long raw;					\
> > +	} tdx_cmd = { .c = {						\
> > +		.id = (cmd),						\
> > +		.flags = (u32)(_flags),					\
> > +		.data = (u64)(arg),					\
> > +	} };								\
> > +									\
> > +	__vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> > +})
> > +
> > +#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
> > +({									\
> > +	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
> > +									\
> > +	TEST_ASSERT(!ret, "%s failed, rc: %i errno: %i (%s)",		\
> 
> Nit: tdx_vm_ioctl() uses %d for ret, while it uses %i for ret. It's better to
> make them consitent.

Ugh, KVM is anything but consistent.  I didn't even realize half the macros use
%i instead of %d.

I chose to "fix" tdx_vm_ioctl() purely because it has the completely unnecessary
PRIx64:

	TEST_ASSERT(!ret,						\
		    "%s failed, rc: %i errno: %i (%s) hw_error: 0x%lx",	\
		    #cmd, ret, errno, strerror(errno), hw_error);	\
