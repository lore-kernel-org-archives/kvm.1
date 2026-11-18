Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035811;
	b=ADYgsNqPlTL/eUxA2d2G8t0r1xBHCmU9Jl1ba9XEcoCSIdXY3e6YHdHAN3mvx/n/5l81
	 StetNjLPnLuakYYWqSk1ctWpi490V4Tc+OmRPcXUqFfJndwzWjeQLvgBbsEeb9Yx4kt8O
	 ust/h19/o4GghU6alw5lV3yZXzxU+0Qqnwaaa0FKBEPV19j1hJQbIJNGPi/NmSX7iUWM9
	 LFBNoojkipR37GPnT9lwi3vKWBt6MGF+tNngfNBXJMiD0W8ZudvZGSr+Y2+gd+ZVAZly/
	 97cfjzqb681pWN9X5NAuxSxd6GTjkqUeb2MO+sRLDNwagTv2asns+F4toM3FiqeJAVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w0jYyrDAiZ6sNDtwFNEu2KIWwBGTIoWsrMaXe5k+QPo=;
	b=D/usKK+G6yyFBtEQA5RMWPrqTOO762p9gYdUmdNfahdP3YAW6LJ5qOvyrf2TIVBa7acx
	 QjXRZynRft9E5d31Wq+EL0W3RvaU1YZD3wsVcffeyTy2CYKG84/nBGjmIhEJP+iAoVbxV
	 sgKxWBj3cRMii/PmO0uXqkbE/hNio9q9h6XzoW16uN1WaPVzmo7qcGMr1m6rAKsqLDNKj
	 z0st+VctdaeHLBzUaD+YIP4Wm3qSyJ1nh4dtxR8vA/GVztV/OSIP+U4uZl7vN8d6XjnSQ
	 aF0/qIZzCLylmBWfyHia1vus8DtuIsfHaThYv7q2BixfCFyFQsIv1SK+D8ELxXjrJKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xbq4KvQu;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D7606A320
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 21:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 928D7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xbq4KvQu
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa5103so884903f8f.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 13:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035810; x=1795640610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w0jYyrDAiZ6sNDtwFNEu2KIWwBGTIoWsrMaXe5k+QPo=;
        b=Xbq4KvQuV6fhATdw3BaCQSkYtthk+zY+Y0RxPPoCSYFlu5aUgbXP5sy6JWZDD2HPDN
         7+vI0HnfrVp8apUNp/nDrq6sxG55AmGhLEY150whxkIfFUkD8R7FHRvSD8+RRvsYTdtD
         OxWJ6JPzaIubVspnVIwdAkWCxrFnIf+Cnr5lqZmlUH3dqbJ9XSsRE6FCUM+qZa6272Lg
         Z5CDkUn6Ch4EoomWkV8AKi9dwSXvmR2N1dAlhQo07XSDy2JGjZL59GV9y8N/Mn8s7UnJ
         Rq6l94Dxk3tizYWawsWSvQMcssTNiMvRfB3w/0nh6CpBxlGXSneTUU+CQJqcwQlB6kj4
         /RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035810; x=1795640610;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0jYyrDAiZ6sNDtwFNEu2KIWwBGTIoWsrMaXe5k+QPo=;
        b=2WMVJcMcXiIzoe2uyNipVfp1rgj/BSebdbiHPopsk1b4eYnLbfeG1ZgGHameytdT3W
         pWMeeRhj9n1jkbYcfgPR4UTPN7Er7DL4CGOielojSLp8zTPt3pWlqbzYH0Z8ZvKCFqsb
         2gOI6YPLn0cviKZXuTQVL2RIjH2/nBL0Dc3AsNcKl4URBged3hcor63h9xcP1ZkHwG/L
         3x5+xa2M1gPa6rliWxkSBk3+vqT9z4AUAZpXQMzA5rm6Hlb415bG/mitgD66/CUMUhTU
         pbxqIU7rgdgIZ8PM8Agy6+gqrwqLMM6PRTpbuYTkvetm98yPGNChWfUuDi4vyav7eP63
         XE/w==
X-Forwarded-Encrypted: i=1; AL+hErE8nkrGJcCWag3wHAhVTMoQVREkLkeD398k3cwPITcVfG5D8vSRZSmlkqgGiMGl544gPHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sCMgnbmlMLkMfhDMQLdeisC4rsX3RK5ziztYLrglurl9gNmlx
	vgcyz0ByfRu7hAEoVSOTr4k7CrKk/vITxmMjV7zNC/P2Z+mNTHJHNs0X
X-Gm-Gg: AZFdTZdndf6Az6luqA3lVRd+eTZ0a1pOjlpsoI49V2f7OhJgZrb6UYDIMqJn6/hg9jK
	6rzbobcJgxGam6NrMFmAjmy0FrtFWvCQZOkHMj16D5CTN8YtvFMH3UIA1/9qGU7g5ZYMwmjoYz1
	sgdqChto1t7O0rnPc6FIIec1SDHVk8lgPSaAP4i2XUvE+KV4vT/s75WXczAZy6qvSMqBXA9RVCf
	zYoyWSew9qF+IqAcZ/LYuBe7lBtKxbRIHP5kb6W42Knx02vMtGehjxlcHOk5h6KQ6aAFzEgbe9G
	+v5eAalAMtzNKIMteoMfg8dMXx0ybgV4Y1OfFgzQkn1ysjfgTiE699RJXt+cX/QRsRJDkU6AeNf
	ZlbTfothxm0YfT+iaOsvLMjdEkZ2Z0JlsFyYGuJvOIRd/5Cg0MoJQzEZCV05g0hLALvBv34GeH6
	kTBE8we8QtgQxcBIbNBkPj/eOdLEm/6cTfiy3R9FAqGk2CFBXc2i1VkL8UhHPdM7U01491MJwhJ
	04EBX8QyRYyJWMfEtA+GNNMD5JZe3fyY771iM05hIrE5dIklobZuNIJdZa2Tf2ni3OxJBpm0bqg
	kXsrJ1ICVf/xOE2a90n9KgtirA0dyEQk+ViIGM8AFK2fjI3Bcb7id0MdIrISxtLPedd69+sdKYD
	PMA4NBvLwt4VakoE7
X-Received: by 2002:a05:6000:46c7:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-4a63bea7098mr5034017f8f.40.1795035809787;
        Wed, 18 Nov 2026 13:03:29 -0800 (PST)
Received: from aura.rhinoceros-company.ts.net ([185.238.221.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm6137397f8f.42.2026.11.18.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:03:29 -0800 (PST)
From: Mark Street <streetster@gmail.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	seiden@linux.ibm.com,
	Mark Street <streetster@gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Defer TDP MMU RCU callback barrier
Date: Wed, 18 Nov 2026 21:03:11 +0000
Message-ID: <20261118210311.103455-1-streetster@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av4Mlz7fOP-EeFA5@seanjc-mac.roam.internal>
References: <av4Mlz7fOP-EeFA5@seanjc-mac.roam.internal>
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

Thanks for the review. I've been sitting on this for about a month,
waiting for Steffen's file-based-reference-counting change to merge
before sending my patch. If someone has already posted the same
RCU-barrier change, that's great; I'll leave it to that patch. You're
also right that the stats/debugfs .owner changes are unrelated and
shouldn't have been included.
