Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577904;
	b=yUAY4HSEO28A8WgcmKB+6VRxwbQIoHtvvMGeNVHFXIYJq7OSzEBUGGWyo1YOb4yfuf5N
	 a5zcKDpHxIfFN3nAq28fIDOjf1t6gpO46+ElnHa7d3+wBp88P68LiFEuVTyXrtQJaooJX
	 sOy31vp4UEsMntdZd6w0TV9CT73CYfxEpIwaZA23vExJj5/ZE++bo490jmGnaOMd/M5ir
	 Ve08bymgh407u4uj+f2EYlP+vDbfarHeurZ2+hugdalV1omFAgeslkkqfrBsAep62GRYs
	 IQUw0dfaNeL25QVYp7J4mGaY5hU/jkZ4HAQY5bXQdJUB8e6brnaVZ8VhHkttnozvPpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YIE8VEJYRWhCkJWvyEOnnndUa73C0JCVATcw0I8ubTo=;
	b=uJHhF16MQU9a0XMDfiSFVXUN4qeZDuIoV5Qywe0qt7HXgnUzUNeK1nKuIhKwkh3LURM4
	 sTqQOWii1Vsv7T7YQpt+asZzPBzsvr5N8pEBxb5QgKTxUbIiuthMAFyqV64oZSUWW2TH2
	 NuYxTtzlv6K5MvtPqu9M8k6nLuwM8Macr5aRVeRphM3j7MCXJ2NldNKKugybtlgcOttjE
	 0zXFvy8rieDJRn2jO1NtQA/Vm3BlPq0wtd6BAcEArlHsJfvpXqBEz+E+s7nKTFBAK5HNa
	 UcReDoWUclg3JZG89lrlpZ10eB6swKSPAHgeKf90AjX48X0RdsaUGiPlQBY95eWOGmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G5AOpCbs;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A54606A339
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A54606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G5AOpCbs
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so1038496a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577903; x=1795182703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YIE8VEJYRWhCkJWvyEOnnndUa73C0JCVATcw0I8ubTo=;
        b=G5AOpCbsvqSC0G/XXSEz2mlVfpHDPTAa3AQVgyRQVA821CP1OX91YR4+/31qMc+Qej
         ZOWeNWEwR4tvJmMFOcybT6Qme9WagyxLzgcKibgtAOBqwNytG3jSvk7O46mMKSH6I+97
         QizErgeXDq8BBp9fxprG6NR2JgrEi9/RnB7c8L1Qn55ZB+T0uCOKF0TKFxnFicSwCvgA
         j95IUBFcLHFo/dMcJDEm9fAthQmBHet3jZ/kuYftJ6k+M2IZvXr8ZLFueFC5nx7wpiAU
         6zMHuHDe7zfNzVJ8XrgLDpEV4MGae2W/bAnglHO5nh9Vd12bXQCTw+S8J/jeuGV23Elx
         13RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577903; x=1795182703;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIE8VEJYRWhCkJWvyEOnnndUa73C0JCVATcw0I8ubTo=;
        b=YRPnLWTscF9i2G0t+/StBHXGH49UviO4plQUea6DieXdrMKEt852VgcX5h8TcSLQ9Z
         YT4XQ7S4IAbLXwY50u6tg65cpNqVmRTyzOrKh/JtLmIH5QwfyeSuI8vDPaekNJPGA9Ab
         SyOq8hQ0YwDnZf6fM/RG4I6rfWtZ8+F7W7QcD5cZUiQS3yMjhZBhBWmFIEOhGOTT1XhY
         J5asK9Q24vBDn6M3vOe+fGwzw/BwV55oVrSioAyP/VuLTG/JtVkcjtvN8vZuYXWP8S6P
         TkNGxoJ9HQterwzcKywm15dwoadoGx7OqGAEZ+Gmq0qokPLkXcRNVn1rw54t2U8A0Hwc
         sy6g==
X-Forwarded-Encrypted: i=1; AL+hErEW1o5P5hdBt2EM8EKOfkdFx4ZTqG1DIU2Qa3VRKKSiq8D1DWBheWbWPgeOlBx2SgL2I4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z//ZPK/Ve2De+8CByWVg8LLBxf2dGb6PehnApIqhgAZvTNDYVTn
	1v64ZKaN5Vt8ktW7oGZLllzw1AYIyMh1M8DbJqvVm0qleJOHCHGPy/1MDMzjsg3E4N5knxWhdAT
	lvNXtlQ==
X-Received: from pfik12.prod.google.com ([2002:aa7:820c:0:b0:89f:41ff:99c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4eaa:b0:3e2:8c23:4db3
 with SMTP id adf61e73a8af0-3f7a1fb906fmr2565211637.0.1794577903175; Fri, 13
 Nov 2026 05:51:43 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:16 -0800
In-Reply-To: <20261105223000.3036448-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105223000.3036448-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441815559.79553.11044729914453170233.b4-ty@b4>
Subject: Re: [PATCH] KVM: nSVM: Mark all of vmcb01 dirty when restoring nested state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Nov 2026 14:30:00 -0800, Jim Mattson wrote:
> When restoring a vCPU in guest mode via KVM_SET_NESTED_STATE,
> svm_copy_vmrun_state() updates L1's save state in vmcb01->save directly.
> Stale clean bits may result in the loss of these updates.
> 
> Mark all of vmcb01 dirty after svm_copy_vmrun_state() in
> svm_set_nested_state() (cf. svm_leave_smm()).
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: nSVM: Mark all of vmcb01 dirty when restoring nested state
      https://github.com/kvm-x86/linux/commit/69a4ba37c75b

--
https://github.com/kvm-x86/linux/tree/next
