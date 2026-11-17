Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944901;
	b=AsJJYolZU81mouiFkPF47D1cJ5PS+JrSdUF62KkY6CHXehE4tSUkT+bksrAfco6Lxvci
	 +6sY/dAb083MnhJiwXhAiQtuuiOZdItlxKz6ko40/uH7NtRQ66nKA/7h08CaH+W1RJ/lb
	 vJJzS1FdscRQFuWzrupgrPyzLwDfLZC6FvHEyXDUkygYUFH4nSKqifaaZv5uXRNbX/ghC
	 2DonliUDBx/MhfoQ4K+p3kwHfZGBVBw9BBGwQjSUpGzuua8FDX1F43ppl+ZexyZNzqWU8
	 TPimIZD2tLbDcc+C7+wlTUk0x32KDGmikngc6vj7lXY0eGmCYd4YsnYDwfERSR5ni5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944901;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=uKJuLqQr75Y+bo8J7GoFF1WkhE7oAHbeqLhg/Qlni5U=;
	b=3bHhcnOFAL+GDiZgFrP+SP3kW/WFX7tI6cIOOwzYO83R75nT0d0x+2g2lWfDIuzqtJUt
	 WrSKUBIEDi/aHsQXN3gmRC2Za/o/DCauNBtAsERBBAcwW4V2KrnAV2ATOWJSKo+l3zWpr
	 KYvGVx+ryXu6ICoBLmYE0AUd4u7aWlIVcW4XH3/NqiGVEou1Ie1HxHtJbpu1qpmQ0a2l9
	 kvHUpmbuuMI5KVxuAZ90jvXlI1rzfRSxSqtMjmFMSp/8KiysaEKGBLJXqoQqkESlbEhFZ
	 VcHWiW2FwAmrI9gVgioTK1KRmE/HwZufVdZRYOlJyfpulDyBV4VJ54SKsiDGWUCmq+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r9BzQqO5;
	arc=none smtp.remote-ip=91.218.175.217
Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75554606A884
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 19:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75554606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r9BzQqO5
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uKJuLqQr75Y+bo8J7GoFF1WkhE7oAHbeqLhg/Qlni5U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794944898; v=1; x=1795549698;
 b=r9BzQqO5ftQk2fg9S98be4uadfEjncKl9L6K8ciH70ZuE02wkCANMV68XPA5PKMl+SDHPldU
 mGX8HaxY00Z3rFxzp3V6ZnYXmMZq9b18bpt5QPDWKpKKOtn9CtZ+IH2CeMt1tI4xwzVlpCg2Ccx
 5Kjko/3yF9WjI7gbNl2mqPwA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 613003be916702b5;
	Tue, 17 Nov 2026 19:48:18 +0000
X-Mizu-Trace-ID: 613003be916702b5
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso1207e87.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 11:48:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHFy4qX/kQ+CorfOAU87eEluaX9uPeh+LMLCtId4pCjbkkPYPsScObhzNwgioekW8n2A98=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SNKuFFK5eyjnW/LYGArPkgF+6o4fg+zF0S3BuXXxf5GqWCmK5
	NXJHW6/foXFxbo7g26+P21scQGN97ZZtXr4WKuUdoqlaOV0I0KIFUHAwSn2Bglbg5US/yNdoiAm
	eh2zCOf0mMi+shJ7U/KTB3WdNRSbIZ8lAJWwQDFzx
X-Received: by 2002:a05:6512:2514:b0:5c1:488e:a067 with SMTP id
 2adb3069b0e04-5c1a21b8c88mr211122e87.16.1794944892940; Tue, 17 Nov 2026
 11:48:12 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109084854.840576-1-fuad.tabba@linux.dev> <20261109084854.840576-2-fuad.tabba@linux.dev>
 <86bj7n1bzx.wl-maz@kernel.org>
In-Reply-To: <86bj7n1bzx.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 17 Nov 2026 19:47:36 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwJ9XTCfrfBLgGjed3GrRtiTnk-ErvPSwU-AhvyTVcnsw@mail.gmail.com>
X-Gm-Features: AclHuK-8bTfTjzWgE2se3igLLysfjqAzQV8BoEmKuQlaC_gyenaFOJ31_2y-pYk
Message-ID: <CA+EHjTwJ9XTCfrfBLgGjed3GrRtiTnk-ErvPSwU-AhvyTVcnsw@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] KVM: arm64: Hide generic ptrauth from protected
 VMs without ptrauth
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Tue, 17 Nov 2026 19:41:54 +0000, Marc Zyngier <maz@kernel.org> wrote:
[...]
> Burying a fix in a selftest series is a recipe to make sure it is
> ignored for a full cycle... Why isn't that with the "massive feature
> set" series?

It's in this one because pkvm_id_regs depends on it. The test checks
that GPA and GPI read 0 in a protected VM without ptrauth, and it
fails without the fix.

Would you prefer that I send it on its own, or with the respin of the
features series?

Cheers,
/fuad
