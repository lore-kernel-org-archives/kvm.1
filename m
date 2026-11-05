Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836891;
	b=H7KyFWpVw4VQTGb04pYYC+QOQtHqIeB2kdT7kYjWIl3Fs5FrYkbXDb2wogFsi2NSG2Ll
	 XHUF/9MG8s72/UPjX1FUsfBDSiUwBjGeUpH1DaPdH2S4JE1uoa9+dW0mJmL4ezDbI357r
	 FvueM8FcU3mvqKuFYHL6nduReZYQCuSkv9rpUB5P/UMQ/DsV3bW0BFUkJej6gjhPI/swO
	 vwHgWzLiZ5C8y/IhRh6hWpScJc58Kc2D2cRJ046aNZRtmyhVqR9e2pfeM//6cGHSfoTdD
	 ixMEc4+CreXRksX65mr1iak6zAhmnOoK6JK14PkT/RE2SgzVe++xdV1mydJ67hVU9dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MRQuzERxrDtzGHqEG5EwaVsi1rkjebx72/ASyR8+7b4=;
	b=lk6MA90S+z+BcjbZE8P5K3o+0hXrOcj7d3bsS8DLT9gIRO1MWUqHrH1gTYVXl09wSiQx
	 VXq9ld71nkD0NddzYM/kOBlglug3rTmvHB9i7pVxg7AxvQOOCw5H0m/B3C6+nbicf93gf
	 smgiAEtH0gkuVJluGj/UCOzDn4lLBQhRLNo4dGigkssXfINCfhQJnwn6xsht0/BwH3rND
	 WNxFgoSZFiXakYV6z23JIKACmG6gbvcGFcLUVztQEG34ArRMtQQx6KTy15R2uBDrsrUf5
	 xUVPqnOF9cC5CnFtoIpbZ9O1PkhyeJh37rdgYhD1wY3kLa19DcQQGbFzImDBd6sZZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Snpy01U6;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77002606A328
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 00:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77002606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Snpy01U6
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afbd2c386so867862f8f.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836889; x=1794441689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRQuzERxrDtzGHqEG5EwaVsi1rkjebx72/ASyR8+7b4=;
        b=Snpy01U6DJld+36enccUIjChmWOPUK5tomxjDFxvm7eAnGQ8AM69HW0+wQlzXucNM9
         rbBPj7yFTRy1R2/Ga20iDTUfthEueY+PI879BSOGzTSL3Li3rWNTH5s+fnpMQzjIabBN
         LF9lWz5kHorZLw8wD6DN4SsQffGRmCF4xmTrf5c/Ql8x07Bi8IO/NWBKvuLNkJs03YK2
         d23IN+V3is66WaMsrwBGqLh8IyTfozjEnI82OvQnHQkf4fOY8R4L0eVas+Oh6fOwQVN9
         WwYVH9h92gu2hky6Ubw44tghyVVBJTs+650mzSHbW7UmssNTxvWgiajoeEHCBOHHvA6x
         BHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836889; x=1794441689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRQuzERxrDtzGHqEG5EwaVsi1rkjebx72/ASyR8+7b4=;
        b=q6L7PBONJ2JT+Hr5mRBucbz10Z38PZKzrM8K5caOOMRbWJ4xCcAwEDlAzF2eDOngtk
         U5Fne24ep/5gBVUrpnAJvJIBldxPZSVWMDw2R3GU/KjPWQDefDbEnG3W8tT9IiDlLt0r
         HFWLm/92nFxS4bdrKa909IRe0jbGXqT2jvM/tzux+EJ9NiqUJtFjKCI+6KRIYbtT/DhP
         MnTNR1vMDSIHH5vSAK7kXSMmjy3sk2v1mndL7P3WhHHqDFqTUUynexNcHfOYBhkWs2P3
         8yIK37pbRe9FCbOc17048runs5gJRalQ8LpjIGky8z4ylNd/LpCJaF5ZAQQOJ6b0iiAN
         wXww==
X-Forwarded-Encrypted: i=1; AKwUvBw/oXi4JfqBy9g5eIC6rEqhtuHJnXaPFQChG6GOECF8yV4hHZI20rVcuz7mtfMhOgvBHiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9saKV5cA9Aaot3XBz6EGPYPk3VQy2ABiejPa9IvHPSpb5xAQOx
	I3Fb7DCyhfaREkExDYvRmtwsGmrxV5+g/r9+2bHlZKa+Ox08QBbYl9Ab
X-Gm-Gg: AYBFou1lphAhljlJ2LEYA/6qJwdgZh5BgjIWEgoP/23LL3e/3DkKvzLmqOCkGuKh0Iy
	5/zDVNRZV2nvdJW+tv700mXtUPF2YRslCv/HMTSMrwd3QmB5COeKN4C3eKuY9q+A/V2YZwxU2Nt
	ZF2Gqypinb5vBULU0coDrHmvZbYkRDt2hG9e/pI3eE1TRpsWKWByt19guiIozf+pbRVqcc0OwU7
	7egPGwHWU4bA27YPE2uPLE98rcq3/PZFLt490yjiEQWmXYw6Cwyg2CQJoSWczZKv0Li0tV1X5A2
	KQnixZPYwuJe/vHcR4O8qSVBEaWR/rxbL06jueWWoVDRJkcQlH9F10nM74wQEaZBpX7qEvH7JXB
	6wyHpLxIGG2oece1+fEuDZ2pIIR8YpAV41ub7CBI8Ka2oKUYezg5N3kYcmPp8mqHo55l5sT/zzf
	MyXrSMQwxrjGsM4cWYgkJwyomdqXeZCDdH6lexjTceEvpP0Kv4wpf4bqCKXhIwqMkaS9ZQlBHr4
	WcKnioyNOn2ccvDhBF5HL5rataizwG/ns71gskzx9Rv+uagkWz2gD4SZeyp+r2dHTxVgri+pqmc
	OlhKkW3nXlG4TdQ1Pgm6K9sQqOor6CwYobbdYBoOFDUrT8PyQX1KRfO8NaJx7OSftPPhkpAZUS7
	eQGptOJsghVE0zBUD+edxx5l38rAgsIOw7coOygqUZVhHuRiOwc8UinPEr1FYAwEY4Q==
X-Received: by 2002:a05:6000:402b:b0:48e:5ea1:260a with SMTP id ffacd0b85a97d-48e6e2c3532mr38395788f8f.3.1793836888628;
        Wed, 04 Nov 2026 16:01:28 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed553116sm6323846f8f.42.2026.11.04.16.01.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:01:28 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: Allocate small memslot metadata with kvzalloc()
Date: Thu,  5 Nov 2026 00:01:25 +0000
Message-ID: <20261105000127.63664-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

__vcalloc() makes every memslot metadata allocation at least one page,
so small memslots waste most of their lpage_info and dirty bitmap, and
memslots below 512 GiB waste most of a page on their 1 GiB lpage_info.
Mushahid's patch [1] switched those arrays to kvcalloc(), and Sean
suggested dedicated helpers for memslot metadata with a pivot that makes
sense for KVM instead [2].

Patch 1 adds the helpers and routes the dirty bitmap, rmaps, lpage_info
and write-tracking arrays through them, with no functional change.
Patch 2 makes the helpers use kvzalloc() up to KMALLOC_MAX_CACHE_SIZE,
where kmalloc() never uses more memory than vmalloc(), and keeps
__vcalloc() above.

I ran the memslot and dirty logging selftests with the TDP MMU and with
kvm.tdp_mmu=0, plus a check that one-page memslots no longer take a
vmalloc area each and that a 1 TiB memslot still gets its rmaps from
vmalloc.

Fred

Changes in v2:
  - Split the helpers and the allocator change into two patches
  - Pivot on KMALLOC_MAX_CACHE_SIZE instead of INT_MAX

v1: https://lore.kernel.org/kvm/20261103234734.45413-1-griffoul@gmail.com/

[1] https://lore.kernel.org/all/20260815142218.85067-1-hmushi@amazon.co.uk/
[2] https://lore.kernel.org/all/arr1VgGZmgUmY4hc@google.com/

Fred Griffoul (2):
  KVM: Add helpers to allocate memslot metadata
  KVM: Use kvzalloc() for memslot metadata that fits in a slab bucket

 arch/x86/kvm/mmu/page_track.c |  6 +++---
 arch/x86/kvm/x86.c            | 10 +++++-----
 include/linux/kvm_host.h      |  2 ++
 virt/kvm/kvm_main.c           | 22 ++++++++++++++++++++--
 4 files changed, 30 insertions(+), 10 deletions(-)


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.47.3

