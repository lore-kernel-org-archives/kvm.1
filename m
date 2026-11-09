Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214266;
	b=rahSxlZFmMRc4E1Cu2y5Pcrswql7S8wloOru/yoV7ynrKvK4om80lis651eU+CYHY1VR
	 K297iTHx+OPa+udjV5Rv1vfBPLQTYuqPBU3owBbpGJlsGkdO4HWkaLDO584YHAlqWMQt2
	 Maa8bVjL62W0MWAx3d5p8FBcMG1V3U+KQYwcuu5RMqZh4F5T0KTC6YHbsCgp0lSkQRIGB
	 4ImeN5jCV6aRh9J516hB9Yo//gZS9AMZpDgR/88y0EpdA+/052u/zAI6cNjS6nMeJLFmi
	 vMdQyCK/nXGmuvtQkVnbpTAiy+ElHzEeGNcRkWPZ342qQcS5dul491TKNhwqfCM3mfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214266;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=wK3Kj9ggnG7kxPcgujmWtBo3WnCYjA2Q28UFcLisF6c=;
	b=ji3X/mgxtK+nCem3bjx1Rr69fRBzd99FWMZmbYIdfPSqHXRoysFYONwEVLY8bcellGHg
	 axCUvZaegN159gm7Kxd0bmHY/dH2nb96/s1RDV0u+MjnGQAqZtjEIxo0dk6s3125dPgvP
	 UzkNQR3yQqc14VAUO2sxQHaaFIkVZvCX/p7ARSNND6x0uRdzaDy17Z9+jdxy7oWPU7Vpz
	 2IXduQkhIgZhu+Mk+DzF3s8yMmAzvWPr7/zbgUZ5b+qefBdRJtCnf0jEvUKIiv01PAIa/
	 YYqHSDtd1Y0EjEarKcPpt/yzxOHo9o1jl4HalVkkHE0jEiUavMM/Qnmw8fnW8JaLRkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aelk5yEk;
	arc=none smtp.remote-ip=91.218.175.139
Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E660735DC
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F8E660735DC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aelk5yEk
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z1iR6/blDGadFjt4UJ120lWqA44OWbGZlUOQA5is+Kw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214264; v=1; x=1794819064;
 b=Aelk5yEkc00Lbm2K98coLlcnHb5AzGWx3TkPoyFoqKE5XOdGh6jyzySuzROwP8lrRoLIauNm
 +brJgg8xmz+geyDxYSPsDF/PYv3FRHV1hQ1Wha/xJs5rNnX8xUOaSU0WP3Ydp2j9m/fgzqPCQAk
 wjoy33cDkD61DnQDkl548d6I=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6bf2f7ddf1fb0613;
	Mon, 09 Nov 2026 08:51:04 +0000
X-Mizu-Trace-ID: 6bf2f7ddf1fb0613
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso2543e87.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 00:51:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH0hcSuffeDexStV3DzPrMRquJhutaDDXXb+Z0tqlLYDs9avkTnAcyDPvTij8hiSumwuHo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wWF8aZrmtmGQR1KEg9m0LJzlv37MET9eFYzu9k7coWmHXnjBF
	F0hZ4rxkpntsvwxRFbyS4KcIXHrrNtVg3kqjoNFD3k+SUCJx3vJbHBJwYbs0wsKP1hmVW67Xgao
	+wxZkDppBL0R1wu6l1vfXk7cvUeKTL7QfYa8uO5Tu
X-Received: by 2002:a05:6512:1192:b0:5bf:f0fb:2c9c with SMTP id
 2adb3069b0e04-5c00b5c77a9mr135877e87.5.1794214259400; Mon, 09 Nov 2026
 00:50:59 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109083205.806619-1-fuad.tabba@linux.dev> <20261109083205.806619-5-fuad.tabba@linux.dev>
 <sashiko-outbox-204612@kernel.org>
In-Reply-To: <sashiko-outbox-204612@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 9 Nov 2026 08:50:22 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwgOuCha6e7PREa8WkJMChtgiRfFZjTBadV-ZjzqA=miA@mail.gmail.com>
X-Gm-Features: AclHuK--kTlM3MBNHvnwf6yTPpfzyPkz-vODHm7UL62nptqv6qWIB2G90_uWc1M
Message-ID: <CA+EHjTwgOuCha6e7PREa8WkJMChtgiRfFZjTBadV-ZjzqA=miA@mail.gmail.com>
Subject: Re: [PATCH 04/16] KVM: arm64: Advertise ID_AA64ZFR0_EL1 to protected VMs
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 08:48, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] KVM: arm64: GPA and GPI exposed without vm_has_ptrauth() in
>   pvmid_aa64isar1 [1]

Fixed here:

https://lore.kernel.org/all/20261109084854.840576-2-fuad.tabba@linux.dev/

/fuad
