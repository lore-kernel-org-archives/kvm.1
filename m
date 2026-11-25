Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622358;
	b=CKhAYW0RO94b6WKCvyRTxU1BLnYTyBZG/0Z7A3GOeqw9V7rQgZonvuAiW2LV680L3/X4
	 N6vbNrgGV/hMRyIyjDQZL5DRcLB9uq1l8W3ykV7+pvQtU5BC1DcG00Pn/GqvzNt7CABID
	 4udd1cR4dt9Bn5fK15lSEu9/CpbQV8pVJ0405bLOrCrYv7fPIR2szeRpDzC+0SNFURVJb
	 P8ynwaskH7gKQ6Ig0ktEQcSw21JTXSZc4/0vT+51HexX/wsRC8Z+hA7KkoKKXgQmpaWxf
	 gbmRRYAkyuV7d+1+FVMgrkY5ZOIAuQ4MXtRekyL4NndPI92eQ+5zFjy5AR68pubhNjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622358;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=cvTi/nNYHR2TYIOUf2vi5rClYm97tIxKBSXMmmYFqlY=;
	b=yLNwjlPz3zoErdC3iF43g7Nt10hWzWs5Gn/ELWh+i30ZvXTSDrrsx5lyzgTlDb5SmeSI
	 rdP+1ZObxrfG2uteZ7B/nQfclkYf7Tr8P4yLUnMFBfAF4nksZECUd1e3OwvXJO+6X4QRQ
	 UCYxjKe3rGR1xBJux4IrE5jrWc/K4vGD17KSipn9CPvna+fMkY3VGkSw1mlWGGuRg0gHV
	 P/aUJyFVS1GlzS7wiE+XRoEc60E2TZA5H6+XlJm2uvBpaU2Box0jArqY6kPJttaH5bb9J
	 6h0BbMHwwLR6DDvxhaa1TM5tjIewi7vwTyn8rL3BfKhoagxl0R17WFfcZ3QzDxKkTKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ToDJvLFT;
	arc=none smtp.remote-ip=91.218.175.224
Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E38606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ToDJvLFT
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/XkNz3r9eFnmSbOvrGYUn0rZ+WAp3AeHIjYmS1q0RGE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795622356; v=1; x=1796227156;
 b=ToDJvLFTerO9O4YPisschoDcMInfILs1heuJfHlE+D2aGgghFAKOjMkssKBs/vZUvdZdHvFr
 PHk7g7I+PlA42+xIS0gKuAtNjHQ0kgz9ycmdPMKWZV0YIcpThqISbHSHOH88B47JnaRui/9nQSJ
 3efOTZXWXg42Y8Ux16oJNAgI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6cc098e775a394bb;
	Wed, 25 Nov 2026 15:59:16 +0000
X-Mizu-Trace-ID: 6cc098e775a394bb
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so29543e87.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 07:59:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHTX8XGhPvTYApxsflbCPT5b7cIrZgvHhr/jpLeVbcOIXQS9sV97xihenlp1YnXOg3GD9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/k+hByq/PPKWGc2kEe85SHoVGTIfJ9+5wYagv8nU276SWa61aD
	aiu+1zk8nnHzgKUyNW4pijUq8j+VHF6cNV+znocBd1dfaPCpx164FC43M0Jq+wcHhg2+KalyMjQ
	TBqeXjr3L+9C2RZ2Gx6KML2Ue3N5tqQ7cnruo5POl
X-Received: by 2002:a05:6512:10c7:b0:5bf:f84f:1d74 with SMTP id
 2adb3069b0e04-5c21a27810amr593536e87.13.1795622354030; Wed, 25 Nov 2026
 07:59:14 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125153911.106793-1-fuad.tabba@linux.dev> <20261125153911.106793-10-fuad.tabba@linux.dev>
 <sashiko-outbox-233684@kernel.org>
In-Reply-To: <sashiko-outbox-233684@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 25 Nov 2026 15:58:37 +0000
X-Gmail-Original-Message-ID: <CA+EHjTz1SuYC9GnMRH2Fe71jxKm1QvoE5tEopBe6k_gFNdbwHQ@mail.gmail.com>
X-Gm-Features: Aa3M54qU1hrnXAD2dBM1Uj3GqNjkJxsnaGRBLC-c83EOnBK74LQNPnC0lvVf4bs
Message-ID: <CA+EHjTz1SuYC9GnMRH2Fe71jxKm1QvoE5tEopBe6k_gFNdbwHQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] KVM: arm64: Report an incomplete feature map
 with WARN_ON()
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 15:55, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] KVM: arm64: unused str parameter and name field in
>   check_feat_map()
[...]
> [Severity: Low]
> Does replacing kvm_err() with WARN_ON() leave the str parameter of
> check_feat_map() and struct reg_feat_map_desc::name unused?


Deliberate. The #ifdef was removed at Oliver's request [1], and the
warning doesn't print the register's name or the bits, as discussed
there. The str parameter and the name field are kept so that this
patch only changes how the check reports an incomplete feature map.

/fuad

[1] https://lore.kernel.org/all/avyZH2g3rrIVm-Fl@kernel.org/
