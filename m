Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325719;
	b=YQky21uazjt7UvclQ3AfbL0J0VzCYyhUcfFHtN5oBnPGopfZNkkOWWPwPo8/AVpV5rpE
	 pY2MWWXHj8lSURCZa6FB2TVSyDKPUUnBYDvtfwHo/9u2cGLreon50X9Jo3VwdKLSA4ON9
	 UwokLzEI8jT/dHUfTnXOtn9XYuAq9C7ZewOUMFByAH1eGxGpi6usFn5Nf1cb3tzmJTB4r
	 RXEo9zsSlnbP9wjGHuxmAtDhg2r3fMvGgPdgJO5rrwdFqguNLl+SrpF3/FjC02EwlBlw9
	 /uY93s0+kMkfgpNwGSsf4ZtZ9w994Mmfv8/BNK2bcZnnofGP7pV01UXiynrxKHcT5Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6krrngdHCsjiOW3bLfxtRylPnkwePlq//L1F5r6HtXs=;
	b=KeB66K7ubzgQAYKceP60QJUgxburQObxSkiB8NIzlmWQRSfNEjSm3hsslD5F5B+ca3Au
	 3ii+ssAksIsUweOn6A4yLmQ1dWpuwWRG+6bICzwn5R5BUxeCgwlbLa+NMU+OJTeZO7c+L
	 c6ad4Aw0rLTSV2N7JpuWql+lo7tWXrbGLQBbt0rwBp0F5/OxYXVvFvVqjtoSuJb0FzxaP
	 gKA79luzhI8utGFzDNgh0mfOyLtUqQSDKAz742vX32m3e6dPOFJu+cGaRf7ff7MCRo6ZT
	 V5FXSpdxKAnaQ3Xz3D5kGttAFiOG3vZmX73NyWdtx6snFQnoQfWtf119yy/IgSWbWCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VEDWmjx9;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4A60A2618
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B4A60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VEDWmjx9
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb5375cd68so19253385ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794325718; x=1794930518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6krrngdHCsjiOW3bLfxtRylPnkwePlq//L1F5r6HtXs=;
        b=VEDWmjx9ptAoyITql445r9a4r7M3NFRes+rAAKiIqo0108JuRGXtjwrsrFF1aGwJub
         tjOjLHcpweM3cxaKwy+gYTKpimW8Sh3JwaVyg21n1qQQBvzxbeV+G/ZEwsCo8TQBLPTz
         MTFd3LK0X2LpE45of44khmYMQaaJncnHcCP8Y8tHETeL/lsBxUhom6olGpAdjhZX8t7P
         i4dv44F9rrNKjMYWvUvjkWBfrv1P1FY4EF0ZkSxmgiYBXfptCh4ieM1+fPMHWgWi/gSM
         pZK2hJZrQ/6N1x7B7zZ0KdR4+yWlo4sL6UlLigySUFU4DkEBcJW7YiBvPfvPPb0MmsMX
         I8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325718; x=1794930518;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6krrngdHCsjiOW3bLfxtRylPnkwePlq//L1F5r6HtXs=;
        b=oA+Zb9V3YXZMH8ihBjlTCgXIKEyDork4J0UbDx32/hQK5fMSAylBDhZomILrLn3VAo
         403SldPqn8TInzwy4X2fP3NlDetB1GQz5UmxktpotFK7/nifXR9ckP6+1Dt88kEp38de
         xWN8h+I/pvX3dleIBdbxUt8WCZUjFqjMjtGeTASC4fVlN/SgkzMr8R4jya4TsZJf/PxO
         HD3ct6ExL4k3iDLO9YumKW0BeeEJjOleCGmMjK9FuwRiclvoMUrALSYR/LGwPw3kNxFL
         aFuHA8nABk9aF0aGoKg1/iqvwx+jezH4KuJrZu4kORT3Vy6+7TAVCRwdjBVLeWQ7B64D
         Dg6w==
X-Forwarded-Encrypted: i=1; AL+hErFBoGVjO5gWO9ddmIVwVVgkdVun5K2dMPPJClvNkey/jameeD45KPPoA8nQ26AsVEAfPI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ss8VzNuHAJhway/oLpPpiwjTv64Ih14YucNK0HNf8NJ+nrvOD
	oiprOZ28n5fpYgtusX5lt25vi1Zj97EtMmU5f8EONxDAk8hJJXsdhrjizqksDIaz8VheYaHcjmc
	nIGtPEg==
X-Received: from plzu6.prod.google.com ([2002:a17:902:82c6:b0:2eb:809:b8ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d547:b0:2ed:218:6043
 with SMTP id d9443c01a7336-2edb93052e6mr23931165ad.59.1794325718280; Tue, 10
 Nov 2026 07:48:38 -0800 (PST)
Date: Tue, 10 Nov 2026 07:48:37 -0800
In-Reply-To: <20261110110724.3614412-2-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev> <20261110110724.3614412-2-fuad.tabba@linux.dev>
Message-ID: <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Fuad Tabba wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..da1b76ceb65e3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4461,6 +4461,12 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>  			break;
>  		}
>  
> +		/* Like KVM_RUN: only the iteration crossing the soft limit uses the reserve. */

Please don't include AI comments verbatim.

> +		if (vcpu->kvm->dirty_ring_size && kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {

Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
clobbering vcpu->run->exit_reason.

Side topic, kvm_dirty_ring_check_request() is rather confusing (clears and then
re-sets the requests).  AFAICT, it can be this instead:

	lockdep_assert_held(vcpu->mutex);

	/*
	 * The vCPU isn't runnable when the dirty ring becomes soft full.  Keep
	 * the requests set until the dirty pages are harvested and the dirty
	 * ring is reset by userspace.  Note, checking if the ring is soft-full
	 * can get a false positive, but not a false negative, because only the
	 * vCPU can add entries to the ring, and its mutex is held.
	 */
	if (kvm_test_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu) &&
	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
		trace_kvm_dirty_ring_exit(vcpu);
		return true;
	}

	kvm_clear_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu);
	return false;

> +			r = -ENOSPC;
> +			break;
> +		}
> +
>  		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
>  		if (WARN_ON_ONCE(r == 0 || r == -EIO))
>  			break;
> -- 
> 2.47.3
> 
