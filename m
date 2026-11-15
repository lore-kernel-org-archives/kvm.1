Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760679;
	b=X4vDXzXFQHSTkkJFTkRecWrQg4EGPs0IJ6cGnDi15YhVCaz6yPuU1LC6fqddf85zpZOI
	 9gBPbnIzwkmc9qe4hpjdhsTPohrdlPX6wPeWqOhMJlxif5vNhwMLH+hQRu7+xkcExJs9G
	 oCWAenCV6IU7GWZmF3hgUPYeu2aiAuetE0zsh5r25lmHhdrMPwlS7YluxzBQrNzFuU/L8
	 AU0qOzZxweU4E87nCD6Pw+P3eDCNfnFxgltw/BCRj3cxPPnJG8qe3UiWWM/Qj9fhmNBUV
	 th80gLTndtVTV5i/0GHrEBddE17BQr27kE2uvzlSGgW/mI4WNRhc+ao0hzc+zgcrDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ymzKP1oas212pEhPX2Z/5nMyyWnw0Gl+Dhw7a0DAT4Y=;
	b=bjdoJin+GxF+9PxJXIzpyMIltVfpA97Ax4OM4xTMDxbTGmFMIFICZg58sQC/Doe6debF
	 7KO3CCGBg8p2lqny5rSAB930KenqcxTixR4S2GlMepwYL7mKX41y3SxMU2TBwJUK2eAP1
	 JY9IRt/dMAzbPzBAglMF0OxYjOrXQ0Y7VctELdVSqgttMkDo/5CdBpHVee0frd/8uQH97
	 QEWQ8ygkp7kmfK8yhoMxKU/4QPV8TPB73KO8OwTsGG5aKB3yNIGoFUm8v2iNHTBmnMAXL
	 MM5e5q99x9pSagMf1acOd+N8tZhyKveHiV034Bzt3JrA0LAZKWsUWC1Z3D9hjxMWEtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XWtr00Xx;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21125606A31E
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 16:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21125606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XWtr00Xx
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37071c0f42aso3915989eec.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 08:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760678; x=1795365478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ymzKP1oas212pEhPX2Z/5nMyyWnw0Gl+Dhw7a0DAT4Y=;
        b=XWtr00XxTcJ8dR3zblXxv1NzAOF3iOFj2kpCoR1bxg2LYV7/Uvhtg613igZja5iydF
         TZ/3i2Jw+l8+ihGkj1tu/CHlGBq+aNR+SlwprCsBkcyLLdydt+IS21UDiIuWiE+Q648y
         V7tvt/wUjQQS8fdbfPO+nmzBLUNFqNLNu4mdalCQSO417uhsvQ/upCkMfXZJ/u7WneMA
         RZAu23n9Z+4VnfxyCucFFIHtqX9LOnXzTqqZQz7n2tFF+6w1Ltoj48nmWIh6rTyK1/Qm
         0s5BFkjcLHSiixf+mDA9UIhNKQGf1hI8s5dhxWcV+bnEwgD15iVrgv1jmVR7197S2A/G
         YOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760678; x=1795365478;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ymzKP1oas212pEhPX2Z/5nMyyWnw0Gl+Dhw7a0DAT4Y=;
        b=YdqOJn1M2xdz4Gd98yOd8gsfgbhx9yZ7oeOVJ44xVxD+sG0twMc81FpZVi/PrXAe10
         OJ72oHUqEgJvTsA4Jln2KUgBMLk/YeBPc6swNj4RmNh2PMckw3suJrJ+4238sn90ETuv
         b2A23foU0sdzZrfYlmfUKj+unTnCeC8mo4DNOx7KxiWsFdaK0XFwUKTjmMwkPOK5BYxz
         cGZe/v08Xy3K3TiLkO0elWyzPyEjSb9JhmSyJB0ssvb8RUw3KYMTA4P+gX9WVOBt/xAO
         VpCSPpuS+wZeUkffjkpMl17xsiCavtI2o3jEuRBcPOshhAp1GcBWorGdxZOnYMW2YlHJ
         uRcw==
X-Gm-Message-State: APuU4Z9hi6ZHXWMIPUioJFlYROWVTvlJJz544QJk5wEq8XLT0j/se/QM
	N8wothhHRaVOPFh4+g5d12+hsa1BcnFL7QrDzayC3+flpEvbmWKFUZFWBaBk0EpGpGI=
X-Gm-Gg: AYBFou1YWvIT+tY64gDOOBiBG/M1BFXp4pLTrmEvq9d0+KtIr8bcDzCTPbBY1ulMPfb
	M8+6LW9//++uvzmZ9xXYdhCKkFfLIDenMx7yhNCf/x4X+lGUIyli7htbTN44sbnn8QeM4JSa9A6
	Abtw9neGzdPFPtjKRDHkFbZ4Ftdf6A8OP9CKei09mmCM49qSmTjLUlF4hESB7Y/oVPgYryTbqGc
	nMjYaoxdw2vtAS0W7rZVaWZk8CBPM6NxSK8BFZ04AE7s76uSAG79cFLFfDmj6SwvtqCvvI49nWl
	wI34fPPC9+XNtpcd8XmYtlj2Dhfx37iJLCwu9wJALqvxnLNFO4GcEJVse9tyECr0gbaf2RBmdg5
	qml/jgelpEGNCYkuOduPOg+ic96nxH4tQk2WtnPRVGFTlkjY7hvPCufyLm+vbbwm9JhfledEpCi
	L5oQclucKYHiZoXf7YCAP6POI7M/2VFDf880/Ik9XM0dtnL/8i2nx5cyH2khkvu2/K3xKFdjpwO
	NMcm/4iD7fU0IJFzXh5Gl30xcbeYlwEB3bfR1o4LNDqIyDM3FdiIoua9BFhD1tuvJ58rxPW3sK8
	4mKwcgvpuPS1j4reSpVTBj1BF9kYTgyltVUSDoRQq2ho4EnmHOwxtnFhJQIWmg10/tkR
X-Received: by 2002:a05:7300:fd0d:b0:36a:1f:9b74 with SMTP id 5a478bee46e88-37967ed53d3mr11417188eec.27.1794760678243;
        Sun, 15 Nov 2026 08:37:58 -0800 (PST)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm25654282eec.17.2026.11.15.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:37:57 -0800 (PST)
From: Cheng Yongkang <teel4res@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KVM: x86: IOAPIC EOI can race with KVM_SET_IRQCHIP
Date: Sun, 15 Nov 2026 08:37:50 -0800
Message-Id: <20261115163750.227354-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sean, Paolo,

I hit a race between a level-triggered EOI and KVM_SET_IRQCHIP. It
needs the VMM to restore the IOAPIC while vCPUs are running, which
VMMs normally avoid, so it may not matter much in practice.

kvm_ioapic_update_eoi_one() keeps ent = &ioapic->redirtbl[pin], drops
ioapic->lock to run the ack notifiers, and then takes the lock again.
It does this for every matching pin, whether or not a notifier is
registered. KVM_SET_IRQCHIP can take the lock in that window and
memcpy a new redirection table. The EOI then clears remote_irr, and
may call ioapic_service(), on an entry of the new table that the
guest never acknowledged. The outer loop also continues over the new
table. The KVM_SET_IRQCHIP documentation does not say that vCPUs must
be stopped first, so I am not sure whether this is meant to be
supported.

On v7.3 I alternated KVM_SET_IRQCHIP between two tables while the
guest EOIed a level interrupt, with no irqfd or other ack notifier
registered, and used a level entry that can never match the EOI
vector as a marker. Its remote_irr went from 1 to 0, after 81
SET_IRQCHIP calls in one run and 30 in another. The code is unchanged
in next-20261113.

One fix is a generation counter in struct kvm_ioapic, outside the
copied kvm_ioapic_state, that KVM_SET_IRQCHIP bumps under the lock.
The EOI path drops its match if the counter changed while the lock was
released. With that change I saw no such event in 247,039 SET_IRQCHIP
calls, and basic EOI tests still passed. I can send it as a patch if
you want one.

Thanks,
Cheng Yongkang
