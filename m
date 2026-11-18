Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034135;
	b=Z44euNLiAEXiqX7m42TC6UksJ7IZTANFb8KADO36de3BmINhzaZj0+TBC7Bz1ziCnX4b
	 clfsuD4r76EkboiWNaDjqoEJoU/jgOEaM+y/QljT98zt74rsjqwyVrcJXLhmle4/evHQl
	 D/8tL0nMDmce4/TUD3M0wHM3dP/w74D49xOf+SkylhetdTckHewJX5gkiFylBxHGR7Nh5
	 LUdMoQ5v6Ru7QX4bjy2d6ujQXzcpqBZrj2zV6FP5Iz1rQQR2gtvB1IzLyx7Etz7yGTcaD
	 S2ueuipIh0gAom/zby8PbQ5GZj1sxgym6vjIimSvPSGXwPg8uugNOZrFhZ3VeviTDrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=e4z/RAPfyhYM0nAZxFd/+R4Vt1inNTW4BSIaRYbDcgw=;
	b=d0EcSGCPdLRs/ufYaJxA0cgzWdFoXEWD7bhtWbZx1IxGAVy5Pm/EfKXSO/QH3LE8JARO
	 Z6yYcw3h9xutovxAZpQeyNC+EN8iGZysITcVfE/a2zru8811ba33DZOMJYMxoE5g7n/Kg
	 eItD23j98ZP7n9AO3/PDOCVfLBnG1yi2a+XOu4zZKpDLSyJvuMAL8mAgChGRupIBeE+Mc
	 x7MdXeSgHyEP9tQIyJH/YpZUE3zSyRV7Mo/O9O6pJhHiEoLBNPtZDbg36OKM/GbBKl1OO
	 BjifpD9cUr/u4WOpm4evxcaXtaZdDtLxVINj77MD4YHbDcQWBQYlpl7lkZxhq73CMLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oCGsYpUE;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6860A2608
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 20:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C6860A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oCGsYpUE
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cc89e86e9eso1496775b6e.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795034134; x=1795638934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4z/RAPfyhYM0nAZxFd/+R4Vt1inNTW4BSIaRYbDcgw=;
        b=oCGsYpUEsv7cjMcivMaHXNXe6vIvid5OJm7KhCZTDi9zIBEg27FeI8EG5Mg7GqmJvf
         KWOaKyCXf7xHDp5Lies0dwnw/vS4J1QyvrtUQDrTLkWjyWa+I79i5GGhec4jKafIozwJ
         fWUBqa+67F4Fc2ehRYbiTly6NWqmmUG7SJ+L3wus4iIiHMDbPWXP2PwvzGjjK52+VaG/
         TnaEhgOGoS54HvHNRSNhbyTrdK2wo8xfJqwlMIPUJA226Qtw+yoF6tBbcp0DHOVwZ8lq
         0MnZmGfWgxCnrUK0ImP7UEgNWOVXeucYbyCMcRC7Q0YYOvMWNYJHrvlK/FeXQ4hkMTit
         kMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795034134; x=1795638934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4z/RAPfyhYM0nAZxFd/+R4Vt1inNTW4BSIaRYbDcgw=;
        b=Zao02mvMRQ9OqSbN8X1ZhuJwj5P3iYOQstGBndFaopsy0Ks6aXHVpvX7PyaOghLziE
         9RDMGFOO5a2RxQTJxQnScAmBKeaJsPCUGLL9NueChi7tILFGzhmILgJ97hqajdhxmoqq
         prjcT2HzhWjbLcp6N1pMMWe77aYhed/IQ/Id6Yf63UKywaMSgiP9t8ewPqzhM42/z70L
         Yd8BUQHPKQV6doKFlv5K/7siyDyY4wbdGc0BS6gclROeZb9ycL69J9ff8cl2jIt2z4Gt
         F3vLBt2FO1m86xNTM2nG/Wt+xzdd9aEetPyj43B2vV6fwSmwMFWj3jGrw6e3QQBZkFtw
         xV8Q==
X-Forwarded-Encrypted: i=1; AL+hErGLTeUldZG0u6HZlRMf5KDuGts3NY+sltnOV/CznE+K+YJEB/PAG508d2/NuJzD4s/FzqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x3DWeNJYzTfLoGGDywlmBnucsnt+FOFwTirEqCgKKpSOsgu/s
	LcEhuf7xjrR/KR2bSvhE43s6dHi4ous3YkeHDfwIPyW3QiyCw5K9tEd7ihQiguSA3ju7c3Fnqfd
	WgQWUD/mrNI3NhXmo6DTVDLNx6w==
X-Received: from ilka13.prod.google.com ([2002:a05:6e02:e0d:b0:549:a2e5:e0b1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:308b:b0:564:4d77:7051 with SMTP id 5614622812f47-57740a4b41dmr5099085b6e.26.1795034133585;
 Wed, 18 Nov 2026 12:35:33 -0800 (PST)
Date: Wed, 18 Nov 2026 20:35:32 +0000
In-Reply-To: <avzaDnFRQ2GTHDiN@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117204535.4036191-1-coltonlewis@google.com>
 <20261117204535.4036191-3-coltonlewis@google.com> <avzaDnFRQ2GTHDiN@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118203533.740768-1-coltonlewis@google.com>
Subject: Re: [PATCH v2 2/2] KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0
 when E2H0 is NI_NV1
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: Colton Lewis <coltonlewis@google.com>, Marc Zyngier <maz@kernel.org>, 
	Leonardo Bras <leo.bras@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver Upton <oupton@kernel.org> writes:

> Again, comment would be helpful for why this is done from userspace,
> i.e. the RESx as seen from the guest POV is stateful but the value is
> ignored.

Agreed. I added a comment explaining why the RES0/RES1 check is done
from userspace via KVM_SET_ONE_REG rather than inside the guest in v3.

-- Colton
