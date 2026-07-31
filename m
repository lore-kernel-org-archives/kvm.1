Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FA2BEFF5
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528632; cv=none; b=imWB9QFFe/IZObN7A87+ZcKQUNzMhm3dtnjJYqGSd1Y87IP2wYVIK1n5uyQLBw6Eo9rJ2nHJrGshtxVKflF19EPtxvx8XuXPA30lfEcWhbsEQDHAg2MZuy7lb9Rx09yk84t1SRaxEV+Pl7BCjcQdGWtxMYywMMiGIzfpFh42t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528632; c=relaxed/simple;
	bh=cjtvqra6Da7JbabTLVyMdGWY8L8oS+d2J2o1+ULetdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N6VsTNtcKU0KnsNeCwh1IlJAoZCBrY+a61tVresHDriLfJ2OEO6wb1vbMx2p00DyBTGzIy/PXU00n8WDykSJpBEoxtIa1GpvyF2mlxvbfsAmllCqVC4WkEIuwPTfPKNOe65I3M/x8F0WrPY6wXuSfDcx8SBgoN6AEiINdHowTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v27M1LCa; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v27M1LCa"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so1244058a91.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528631; x=1786133431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pnhgtXGSWYXwjagUjZG+lqx31Qbui9BS9mWbC0HAXks=;
        b=v27M1LCaShef4TgSk2GcU3TTcoYgEqo/ExN2Iw6v6kigKNdp1Vf3551GZ0ymhNeRza
         8k3lY7NiWSv34aP6oXwQ5o6k7NMW9wHP2aY0wR5NW80q7TYOhUvpPMVfC2mFjvHFu6N6
         0OGn600iBmgelJ9BUZoDtus4HECASguBajuxNZ4/Z80t45ORYaj19ErZAVK6f9XKBJln
         YkqMA7LtQt3SeWgrGvwyTDQNovv1lYY3PceY+LtzlCo2zOJg1hYBIvtWk5Ib7ixUt3R1
         bHUlvnBQWouGa12QQSaoyrctw01uhWMwAzq89ZSOfUV+bfcWCiG6r9n9dfJuYlecYnAe
         UUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528631; x=1786133431;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnhgtXGSWYXwjagUjZG+lqx31Qbui9BS9mWbC0HAXks=;
        b=m9ByUbootZ9b9IAODwF8A5G425YCCY0n5xaTiEQDVuUHGJV88tjXFoOxtBUtTvqMD8
         F6HyAhB52IXFyAGUFpuKCEFKm7OBGSUNGMh3JCmRK47gz445Jr/tB74alVWiVqiYZRmg
         ZyHRhWcI8w43xPnBdhlRVGttWDfaG4RGiq3edieGVSOL6xgasQQDtLsvuiEFaKYM49QV
         Z6f9m2UhAF7t0AGmimadI+U8oKomcODRqYYRTzVurn8Dzn+UamZpSecVcT9KzxEQA/Bw
         8P7ktXakdOacgbh30brmNYLVvQR28t0SAW6oztklAgdOf0hCvVuKRXRPOTtVM2JNpqij
         cZxg==
X-Forwarded-Encrypted: i=1; AHgh+RoKrcihVFCNHZwS6Nl4cXpK8kYxP7yAf49CxRQFav5tW3aGkMvFcAB3e0Z669W12pNWqbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8O/fgKJq7uHXaQy5NVdPU1A97ixRedjL0bP9h5vSu+6oaYenJ
	GR76C8g32DuClIvHBOlfw/snxmn6LZEyL3v3xcZMdkF5rZnG0vMWNyx8cDBNCL1KEujsI/DQiGT
	esMII6A==
X-Received: from pjbmg5.prod.google.com ([2002:a17:90b:3705:b0:37d:ce7c:cbd6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a4c:b0:37f:9cdf:f03e
 with SMTP id 98e67ed59e1d1-38fbc52ab5bmr948777a91.33.1785528630414; Fri, 31
 Jul 2026 13:10:30 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:48 -0700
In-Reply-To: <20260714133212.3916611-3-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714133212.3916611-3-clopez@suse.de>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552855078.2715065.17683736613611362664.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Roman Kagan <rkagan@virtuozzo.com>, 
	Andrey Smetanin <asmetanin@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 15:32:13 +0200, Carlos L=C3=B3pez wrote:
> Fix an issue where userspace or the guest can program an Hyper-V
> synthetic timer to have a deadline in the past via integer overflow,
> preventing the CPU from making progress and triggering an RCU stall.
>=20
> Hyper-V's SynIC exposes 4 per-vCPU synthetic timers to the
> guest, which are emulated by KVM. Each is programmed through the
> HV_X64_MSR_STIMERi_CONFIG and HV_X64_MSR_STIMERi_COUNT MSRs. Depending
> on CONFIG, COUNT represents either the absolute expiration time or the
> period of a periodic timer, both expressed in 100ns ticks. These timers
> may be set both by the guest (WRMSR) and the host (KVM_SET_MSRS).
>=20
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock
      https://github.com/kvm-x86/linux/commit/0ca49fbd2883

--
https://github.com/kvm-x86/linux/tree/next
