Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791943;
	b=uULxhxTMjqQV9UE6uxgeD5HmvDvoCUlO9LtMPJX/GGxLdz+NAxsuBMDEWS4GyZvSBHsN
	 s8Oq56/fI4URD3plPAv0Vm5iGwWYCKZUiSfIwey3ysp4Er8si+2fbIFV7WOmyvo1+trjy
	 OiNEGOKJmVDRWFQqhRtnORSiTl3+QNjRaegvvcwgDW05/zIlMFEq1cwswANfn3VS7pnf3
	 FikD5kWtI1aUn8IoSskTsYAtRQhs3N/bo3t+rFc74V5XmK9GPwPy+wv9mJUCdvPRZXK4Q
	 xpiAkN2auNYFRhJE0cKxvPBJ1GbZ+Ur54mkSJgH+KJSYYcs9BfpGtWrbdNzy6i/tIew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791943;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=Sn3eSe67w3OleW5NGD87sSVusifSp8lGeY/kfZic8AY=;
	b=Ln5bEX3PUe6KhrO0sLBcWSaxk+OmvtgJZTzuf14y+rLwJEA/xoTu17K8w/3bo+Ko48IR
	 Jf6UUfBp3eTsuB817ELi8M/KNmHMsfNpvancQHx13lJDEYfpWqsCPpMUCcaaoeEXgOYnV
	 lp2bpDW9/7ySbgiM0yq8imOsvNAGypScb1aQMWNmEnAXavBqRRx/0ywtrixB+HlMAgK9r
	 RjK+Lgd265RcaF7CccS14Nj626Dm0Ov3OQqgMtWktKsIV6p54xMH4w24xim8KFO0jQQxi
	 VmsZv6ROC8gdBJqQH9nlyo3JV4jjFTefbwCQii2alPDo2N+zODGR9q0sKCmoMs1espw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hnaGrckW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kmiu6QeM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73650606A326
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 11:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73650606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hnaGrckW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kmiu6QeM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793791941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sn3eSe67w3OleW5NGD87sSVusifSp8lGeY/kfZic8AY=;
	b=hnaGrckWRQ5XfRnUO5uII6yiMJabXlmUhVnruw0jL6Xm+PNoNt6PHpXFIn00bbPC3rnAO1
	skc+sxKcq6uLK2QEynoccIdYeHpwnGZcV66N6J+FzCckO1spsC8/B9p9I42k2hUbO2FpUB
	Eggy7yolZRcVQS2ecQUOl65oY+ai3Oc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-o45PLM6uNEuFWYwkFRWRYQ-1; Wed, 04 Nov 2026 06:32:20 -0500
X-MC-Unique: o45PLM6uNEuFWYwkFRWRYQ-1
X-Mimecast-MFC-AGG-ID: o45PLM6uNEuFWYwkFRWRYQ_1793791939
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so6931895e9.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 03:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793791939; x=1794396739; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sn3eSe67w3OleW5NGD87sSVusifSp8lGeY/kfZic8AY=;
        b=Kmiu6QeMLUsGlfnpigZik9Kqb33N5OTMRMusjT4I3PPN97mFuIPWR9tKcCVH4QJD9Q
         PTXlPF32K3wO3c+fEWwSkU7I5atSdFhslxoVoeYKfDUv6b1ch4UbwryW7UTk0lwubeEl
         lADRMHj+xnH9orRTaGmcwAdluhOJkYGAf9nLAjH84z4vFrQiTYuN+6YpGjQob/W0cgWh
         IWrgQAApkSlgSNWFPLXwa4urf7WqyKFUE+/EM6i3TolcGBBt7kYLCsxjc3bYSQ/lJLbu
         j7sc60y24+bWH/4vGxQEzMOuwqDrNg+kBhwtASABIVV3Vfw6CHBkIoW18+7EoN/MhZnz
         I4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791939; x=1794396739;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sn3eSe67w3OleW5NGD87sSVusifSp8lGeY/kfZic8AY=;
        b=tTemHQ48G6AeAOtOhQFnUTpQTZXsckOI5n7O3kRA4gkDNSRfkvC9TUTAwi5+Sccxc8
         wNat0mk+v2qbOzbCrjrzzWnjKFPdlmd9IfBWolwm+/zj4xRPr+QE+UXmb/m3C+wlTR0T
         fhjBYrn2DM3sKF4sVi+gQ6ADEANNdghmz4W6JJa1x8JXQrLlX0B3JPSLDsd6JKD2NI3/
         RykMbiMYVVMooXlzNlXKTGiu2sAJGGVSuh1Nmppi7Kzs85wF5s7y8TqDEgVS8sO3SCp5
         mFdWVWZnaOPBWjbVjtOJysavL/4qFJ5ILyaYrVcg4R0nkfV1EsvI1xJMxSAar7tZUPvw
         8dQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVg3PbpGT98aZqF5PKG+T7ZmkRsUAbYezB8eVjTd642n7tQpUoKeYAXfX34Hub68DuJlM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U/rskrps57/hKD+9nHlMewjdJpTj7CEXCWIJQLwb0mKeg5xUN
	nn4KQn5CnVPmwZHf3nt/O3zoeyt3Ms+rGgCAEi1QApoY9izwmlSV3Sr1y+M83oCy+07gnqOHAcx
	RNiyvclAtl25GUzTHtRQmBDznWCMKqU6KplVP9wHi33v7NlTZMHd7PA==
X-Gm-Gg: AYBFou1sJeaFzaJ4lo+H5V8TU1O3vT4KYNVLCLFAfleA77zB8cq1ui/lqi/bP35GJ17
	giMMqdCjrs0F5XxHsVNFc9RMHfH4YmLSTekihvKsRHtXc5/BoblW6wRtQhPIR1kb4/cvy7sSgdM
	pZHA2C/5c7Djp6RdoNN58DImSfEJz86RgBOv92dL8K4OgsxWuPCzv40X/XEwrOsH3A9AHaPUxZb
	wfla1HjazaoKa8Sts+MEaOIxsSiG74hWctI2Hb+XF29pmPls7AJ8n2kIk4P30Ie6AZBMhdWTGBN
	R91dS4x9cKRQ3X19gwNbb9GqyMsLeD39zYDPkpQM2n/8tl7Bqyg8v/J/KlLOh8xU5MVLasE/2Pk
	60fD9pvCD8jiUQwsRXap8prrqlHkmSU7JMhZphmqR3qNGGfUHO3ruaTuHnMAEJkFigeIklhlS9I
	KiuCgMM3t7LMliiNKCu+EXvZCX8GRw9FPkOMi/2w==
X-Received: by 2002:a05:600c:4e02:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4ac19705e02mr339637765e9.32.1793791939064;
        Wed, 04 Nov 2026 03:32:19 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4ac19705e02mr339637545e9.32.1793791938760;
        Wed, 04 Nov 2026 03:32:18 -0800 (PST)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de. [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4527fed5bsm60945795e9.3.2026.11.04.03.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:32:18 -0800 (PST)
Date: Wed, 4 Nov 2026 12:32:17 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Mark Brown <broonie@kernel.org>
cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
    Oliver Upton <oupton@kernel.org>, Ben Horgan <ben.horgan@arm.com>, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH v9 1/3] KVM: selftests: arm64: Report set_id_reg reads
 of test registers as tests
In-Reply-To: <20261103-kvm-arm64-set-id-regs-aarch64-v9-1-ab32bc79fa9c@kernel.org>
Message-ID: <4df3cceb-0d07-d787-b5b6-0a28433116f3@redhat.com>
References: <20261103-kvm-arm64-set-id-regs-aarch64-v9-0-ab32bc79fa9c@kernel.org> <20261103-kvm-arm64-set-id-regs-aarch64-v9-1-ab32bc79fa9c@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 3 Nov 2026, Mark Brown wrote:
> Currently when we run guest code to validate that the values we wrote to
> the registers are seen by the guest we assert that these values match using
> a KVM selftests level assert, resulting in unclear diagnostics if the test
> fails. Replace this assert with reporting a kselftest test per register.
>
> In order to support getting the names of the registers we repaint the array
> of ID_ registers to store the names and open code the rest.
>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
[...]
> @@ -684,11 +719,20 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
> 			REPORT_GUEST_ASSERT(uc);
> 			break;
> 		case UCALL_SYNC:
> -			val = test_reg_vals[encoding_to_range_idx(uc.args[2])];
> -			val = reset_mutable_bits(uc.args[2], val);
> +			expected_val = test_reg_vals[encoding_to_range_idx(uc.args[2])];
> +			expected_val = reset_mutable_bits(uc.args[2], expected_val);
>
> 			/* Make sure the written values are seen by guest */
> -			TEST_ASSERT_EQ(val, reset_mutable_bits(uc.args[2], uc.args[3]));
> +			reg_id = uc.args[2];
                         ^
Minor nit: this could be moved above and be used in 3 more places.

> +			guest_val = reset_mutable_bits(uc.args[2], uc.args[3]);
> +
> +			match = expected_val == guest_val;
> +			if (!match)
> +				ksft_print_msg("%lx != %lx\n",
> +					       expected_val, guest_val);
> +			ksft_test_result(match,
> +					 "%s value seen in guest\n",
> +					 get_reg_name(reg_id));
> 			break;
> 		case UCALL_DONE:
> 			done = true;

