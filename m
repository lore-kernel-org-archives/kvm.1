Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577811;
	b=qkVStDvvoNap01V+74WVGS15THGlIgIfQyIJVGPhjCwopm0mFg07dy3kEyfjbAWVLuM8
	 fAXT7kz1olAqNEqnrZG+FNTBzYef+rK4m5dC//2+ua3D7FJyrhUk4xvpyNVH+gPPkmIE5
	 b36zTnQgroFSNgqozvHCdCu0xfQZWhqWPYDKvEx9YLiaGLZuqIIwJBHK0NJOMvaVfXqJO
	 qg7MjRuJgC9zwShzy8IgYNgmblfbRn1IN6HQYzr7zNPtThgPy+9ZUdrO4YhO2a5CRcaej
	 Gct6E5/V5Pg7p7yj6gZcjB6VClM0Gw7CBy8x8CRf8KMoyvyUK0q2CD4xSzGun9yPiuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=1Ifrh9LQcFbOFvyLblUunEr5sv49cIT2DX1exlzTL4k=;
	b=N74Gc5JF5Tuw6yIwGCKXlHfAgMkv6Noo2JY2+JBTsAu2GoLie36FSm9SzA7d1HW6D2NH
	 I4iYjyC/Pzyp5Kh4gV+txaRrElRtBR+rBLmWXe5+0FSwvBS+FeoLZZdr9rHJE/ZHL6uDW
	 Bju+krqu/b3TQ0WjM0gfAhNr79I7xqT2wNDUAVQKL12thg47lfMUPlEUAEIpeby5nNSEh
	 YrPqvbofTmBZpAT1XAx1IXzbxET6D+iPav7W/9VKb5Rq7MVHoUQrcy5qI7C4VX+uzu5mE
	 aKSSRfOPNIyASsaAdoqmtnn4dujwe1FQE+QiEZPWTiiawhefR9pEBjl75YrPIjzbU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="IPGFm/77";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DB606A881
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809DB606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IPGFm/77
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb8931aeeaso524534a12.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577811; x=1795182611; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Ifrh9LQcFbOFvyLblUunEr5sv49cIT2DX1exlzTL4k=;
        b=IPGFm/77r0uEK4qxXqvVYYz6Og1lMtmTjLcZtDomjktK/YmjMYljTo9TDwRlRTlyom
         TY+5rj/fAbW0EAfdur1RaFxZkUCdqcSlf+qBCC1oLgdJSWQb5ciENeAW7Kd9gjSBNLA3
         bItDO5dsKlIaYEUzfbaLqIemRTSziyDJm75vZUmcHD2Woa+I0Un/Uk5zmTFrpoyyJqL9
         unu9x3cIXG3+NyFEA0EbGRNSqjYdSEZALqQZ6deaTdjmIzb/0C5h28jDwXRLXxcbU/mx
         USovj54f2ryGR3fCct9sKR7lzlNDmKYN4sKOHO+j4UmCPIfiUl1awgjU6cdfJULWq7mK
         e47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577811; x=1795182611;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Ifrh9LQcFbOFvyLblUunEr5sv49cIT2DX1exlzTL4k=;
        b=SjvjKrPnyDOIUq7yKng95735iMTnZRwSgcMBkoy3O1B08ARUoL7Z2UoIRptKL6ARAt
         tVeJZsbySCbRcabpyL/T1HH0FL+Gee3cu2ZGCPF3pN62U03tJHlTGxEwyETTKbA8pi1C
         TpuWffjuELSAfL1QN/v+HkrIkyTs6Gu2OXVk2dtvlAnZEu0WWchhYhIBZJBZ3ETqpRqh
         9+sOtidd9kZ+h5SihFN9yM0qbeUI0xEguHUz0M5oV9AlZyhMVeRk9K1T+Kt73lxJ9Tox
         2V2CSlWkJuWO6U4416TXcpzWYay5JlE4xddeHRmIJA+uwoMe/wAtu5UqyAQUs02WAzZX
         ccsw==
X-Forwarded-Encrypted: i=1; AL+hErE2M/FTwGfXrWPNdoghjhfiVFXOJnl9RpSNm34x42IKuyHz2dkwefroqSrwgDfQfhL37uk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eihCq3b81h11gUnGt2Uo2SAQtMiCc6CPVRHwjLhwJbJ/yTpuR
	JLVG7mvMQ2JdJMaG4zmoxe31FToiqlXKxNSlz50e9qvCkiU6TzMO5JkErppbdhtBiPXyeJt2aXv
	nIgr/og==
X-Received: from pffj8-n1.prod.google.com ([2002:a05:6a00:c2c8:10b0:8b6:c93c:12fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3e02:b0:3eb:abb7:f92b
 with SMTP id adf61e73a8af0-3f7a84cefb2mr2101207637.21.1794577810682; Fri, 13
 Nov 2026 05:50:10 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:50 -0800
In-Reply-To: <20261015083123.790030-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261015083123.790030-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441822886.80755.5926985359947191603.b4-ty@b4>
Subject: Re: [PATCH 0/2] KVM: x86: Reset MMU back to the root MMU when leaving
 guest mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 15 Oct 2026 10:31:21 +0200, Paolo Bonzini wrote:
> Fix a bug where KVM fails to unwind vcpu->arch.mmu back to the root MMU after
> leaving guest mode on a failed entry to L2 via RSM or KVM_SET_NETSED_STATE.
> If KVM also frees nested state before the next entry to L1 (or maybe even
> after?), trying to construct the shadow root will hit a NULL pointer deref
> when trying to get vmcs12->eptp.
> 
> The only known instance of the bug is in patch 1; Sean's patch 2 avoids
> the moving the reset to the place where the vCPU goes back to L1 for both
> nSVM and nVMX.  However, it conflicts with pre-7.3 code due to the separation
> of kvm_mmu and kvm_pagewalk; and it will also conflict with the stable-worthy
> v3 of https://lore.kernel.org/kvm/20261011001303.723721-1-mlevitsk@redhat.com/,
> so it will only be applied to kvm/next.
> 
> [...]

Applied patch 2 to kvm-x86 misc, thanks!

[1/2] KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry
      [already upstream]
[2/2] KVM: x86: Reset MMU back to the root MMU when leaving guest mode
      https://github.com/kvm-x86/linux/commit/c0e3a3724c53

--
https://github.com/kvm-x86/linux/tree/next
