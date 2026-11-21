Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223981;
	b=3uJYiFrRdWkJK3mA+8u2PKgJ/zFvG2tWdvTZe+bke2yzGuNRru53pqymJn5lefwnEfta
	 Jusjb5AyP6TdGlDme8orgHpN/x/ajLvJEWcTsneal5o6mdjouxc9q7MNS0QhkDzZqDx9M
	 v7U8fkAJkQaV45UBLS/w/8v9b/VVhQX3ZUbvHNWe58L9I9tE6n6YBLxOdpVK6Pwp1mhIs
	 I9DSjIN0xAzzoSIQeP/v4zfYD6uQC2vK4uexj/jzfvAJonDaLlS3ZQJ3MwQiRDjWfkZNG
	 Rd6T56wk4+YoZVMaQ1HsvKjmTGFLWfRnXXVjBF/weZ4KrjOOHNUCxZkPTOFUnVMoeIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=boy6I7YzdeV1IlgS2ODm4n4eVmwaOPrG03iw2OUgD9o=;
	b=ZJwMPlx8aR5Co6n2HlZ6uTrRUytzP9s9w9sEssdQFAK2AN0+xvr5RkWRGh0cXUbdkt4U
	 4F9nrCRjh0f/6bActzwNond0VyjaiM4yflzt6ssuxTtBEhoUjT4LETlv69dj/jACG0d7U
	 Ha+TkU9o5ptpSwEF20hhg7M0EmPRGLVb7yaou9uHwDBqxZappnKfYfsNFOw86Bb/OFcS0
	 oQ3/MUk6Zo4A+5GssteiuVS1fWb/uc2lN6eVCJRVFwD3Pe5nhprv6N9zQ5xVal6ZQI9s3
	 SY/e7DV2OzPRdkp5j8RgT45sb/aKeHvGLmVzISvqWnKMcgWgnOvO6JXEtafcwvrQDWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZbH2MK9D;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6B606A68B
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 01:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C6B606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZbH2MK9D
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb5375cd68so16130885ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 17:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795223980; x=1795828780; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=boy6I7YzdeV1IlgS2ODm4n4eVmwaOPrG03iw2OUgD9o=;
        b=ZbH2MK9DAY2FxSG3Y4gngUfmRNmM/cRJIlLMfpYITyMkBMgM5x6MUdRkfCXG6fc4E1
         ZBY82La6PAba57yZRG4kDO347m0ynuN/48NBYIFFASf87clrhLkKKCFRnuWdpGYtqpoL
         ElRvL2OD9hBLotFsP9Z3eUumNHdFWe0ly+qjlNHGY90ia/i4GL2p+CCJyKLVcac+RtEL
         sL6lR/X2FzM8I81JdyXMuLzuXPGeskAwwh4dRcSUWFlBxMqHyp5ioNLDyeX5n4lXL+6M
         XfIwJ+ytuMiygZ35LNrGspJggi4LsyLC2K2Xt2IbxVksw+8hx/CjUj8zAp2CswhL005g
         9VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223980; x=1795828780;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=boy6I7YzdeV1IlgS2ODm4n4eVmwaOPrG03iw2OUgD9o=;
        b=U9EavkWS0G1/5g/zXxOjkFe93zhKqVqwliATmeSQ6fWMO6GmJ+mQeJ31QfGFtiWVSd
         VbRRn5vRg6CChNbA3Kyr7jgXrrR2sgfeP3ulEDwfTNC9eqpPh+mYXVzJnwaH3waSOwRE
         q3JkWZyfhQ+3spdczaqcOr/VOF3VORdYygR2qP4hvkOAU0wLI2IPTOr24pgoTeoWH+cm
         12ix0RywVuh4F8NCdkNijlX2JQDXcyYyrx17JASgV1IJ4TiaAG5birfYr2+FzK1Rc1KQ
         btW0MoDDvZYTG33v4MS0zQD4ktbnjhw0Q39nyBi1v6F4Q4P4vSbs39OueWZR1mqVg6Md
         869w==
X-Gm-Message-State: APuU4Z8nQkZkOhZC6kicBjqADhLMHE4UChthKVALIzQ0jYfaIx9/Sjws
	NhWOvyw1H/Gy2MyTjuiJSgTZZ5pSSr90L0GlWhynMIZmFaMqwSRtJLCq/GiOJ/xlj0vo4vBQAWg
	s5ujX/A==
X-Received: from plhk14.prod.google.com ([2002:a17:902:d58e:b0:2ef:dcba:ebc9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e811:b0:2f0:22b2:bfe2
 with SMTP id d9443c01a7336-2f03f201151mr46755895ad.31.1795223979813; Fri, 20
 Nov 2026 17:19:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 20 Nov 2026 17:19:38 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121011938.433314-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2026.11.25 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for next week, as most of us US-based folk will be offline.
