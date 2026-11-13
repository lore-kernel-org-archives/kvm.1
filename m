Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577899;
	b=KgVjf0nbXgB6V0IlHSp58SKNQQPmA0kF6oUDXB6aCqS651WaB/Q8hnhiMu5kkWUYZ5mM
	 2cnKcAc77t93rdY4i80nxEq6Wo40rUvUEHWvR/3rrHK8Lck+tFldlIR0pUV0BjMWDQfey
	 Y0Ikc1V5mZ+u0TMncvmWA9z3u/Xtchgt0TT3tqtIyH0ebIQjVxtMzZdGEhMJYT8vbxNTA
	 NCj6gqYo2rgMcJDMK3usEVAAUIJxBvG/+DomJswSeLq2EMp38i2w3bnT6EqPC1SOHP8C9
	 U6QPwNTDC/YWnDrEfnKJnCZ9wMlNgg0TgjX1A0f8M2pCGD+iJXId8eaacrD/drkyYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gRtvoiZhikzBDuUhHQrMkpxqO12wC7yZwkmH45ecaaQ=;
	b=CrdgwNEu5UNiiaxGHN0WCc4ATlrCd4ExWkWybz9VVHApAiQ/yKtZtIcVrA4dL928mjiJ
	 MIBJH7mAVRm1sl+cL7chaFp6zNpdzklomBePVMeBaLyV6yCX3iql/I89sgcB35yIl8J2B
	 qpPiGues/kjyL31n9H7qpKT1i4EU/2Litv5Lr8g+aGpvylhAx5Ozsva0P9lrTwJ1y2UfZ
	 qZqGaH3FA7BWb2Ujm4JqYrfo88TsC98uqxtQgCVLK5LeHh8fjDtCuaH3VeInncbJU6RyJ
	 KclCE6IOJdcrh22E04Q0Sp00UtfS0XUhz0TiqgAwUGPN1ZWp5B6XKGr2b2xJJtj19Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Xb/vAiJZ";
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE4606A33D
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5CE4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xb/vAiJZ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea381ce04fso14691635ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577898; x=1795182698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRtvoiZhikzBDuUhHQrMkpxqO12wC7yZwkmH45ecaaQ=;
        b=Xb/vAiJZ9heFsnBM+FAN0sYPd4RAib8v7zbAg8hy6WkZ9ncobwidiJH+lsBWORz9iu
         qvLXVEmuWOHBU2SrMPrkWPgoINRwEDxN21BWiE75CUFAtlsijLOro6OfXlw2iSzF6LZm
         81STDraBJ/nAmWGOPN7kJUgJWHj+ilcxCAr0sMrpijYaW1bfmO1ft8cAxLehe2JVQDfu
         ZnAQGvJlGAXHiWMKr0C8cJ3mCdLxsGl+/rwbsAR6e4Ep0trW0y4eeB78vqC+2kO26HB7
         qZu66FNk9rXH/kENvWXlYS/Si1hc/JOB4QHxEMUe5TUsFuoMSWQ4RhSdYIez7srR4JRe
         v+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577898; x=1795182698;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRtvoiZhikzBDuUhHQrMkpxqO12wC7yZwkmH45ecaaQ=;
        b=n/y5uHEcA/oP64DYusZ3g1vlp/xbhSXgiGygMPt8gUuL41cB57LkykMyGIjLnwJUKH
         K3tpjYZPXSmUXMnqV+xL7TYEIuEVcPPFhLc7pEAGhm6skjBSLZ2vCQei1TylCQ8bfOrW
         3ZtehjjJ+gdMjLbKpI20rw1oFQhmz/4QV0CfLL40grw5LxzEi2wgYrc7BJl61pycypUh
         PLvknGhVusUk2U8ivXb7YAhj4E/yH/6sHVBNfdiKCx7TvkNKyMRYMEK7IR/sKc9GnjlW
         w/mRjKQ3QPMIQMRPcJbNQtjR4MDUSKKC7LqFTlbJDdPfvf7Rw13NvsmPxrE4EdYUGyX9
         TV6g==
X-Forwarded-Encrypted: i=1; AL+hErFpSScc8fRrgq6tZguOEdq04WShDKhjsyI0NjvCJDFIqBfteptJc+dctZ9FxDJM89YS0B8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qUOTf0IFcOJKDeOMqIDCaVrPatez9kn9rBkIdK+gbXUVa8niG
	KEobV/qfNsMYJZ55Uej8kB44M8AVjXdxi51jE05r4AlDPkB6M06PqJB0APdgKuzNZLmZw3lDjdR
	Xe4SWMg==
X-Received: from plpi12.prod.google.com ([2002:a17:903:3c6c:b0:2e4:9044:4638])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b87:b0:2e6:1c24:d5f2
 with SMTP id d9443c01a7336-2edf21c1da4mr41606505ad.36.1794577898080; Fri, 13
 Nov 2026 05:51:38 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:14 -0800
In-Reply-To: <20261028132657.1416783-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028132657.1416783-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441795195.77952.4217273325210388293.b4-ty@b4>
Subject: Re: [PATCH 1/2] KVM: nSVM: Set NMI_VECTOR in synthesized NMI exit_int_info
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 28 Oct 2026 06:26:52 -0700, Jim Mattson wrote:
> Include NMI_VECTOR (2) in the vector field when synthesizing exit_int_info
> for a pending injected NMI in nested_save_pending_event_to_vmcb12(),
> matching nested VMX's idt_vectoring_info_field synthesis and the APM.
> 
> Per AMD's APM (Vol. 2, "Intercepts During IDT Interrupt Delivery", Figure
> "EXITINTINFO" and Table "Guest Exception or Interrupt Types", and "Event
> Injection"), bits 7:0 of EXITINTINFO hold the 8-bit IDT vector of the
> interrupt or exception, and injected events are recorded in EXITINTINFO as
> though they had occurred normally in the guest.  Although hardware ignores
> EVENTINJ.VECTOR on VMRUN when TYPE is NMI, EXITINTINFO records vector 2
> (#NMI) if a #VMEXIT occurs during NMI delivery.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/2] KVM: nSVM: Set NMI_VECTOR in synthesized NMI exit_int_info
      https://github.com/kvm-x86/linux/commit/894f03b50b7d
[2/2] KVM: SVM: Set NMI_VECTOR in event_inj in svm_inject_nmi()
      https://github.com/kvm-x86/linux/commit/f04911c243b4

--
https://github.com/kvm-x86/linux/tree/next
