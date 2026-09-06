Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639821448E0
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698021; cv=none; b=fyvqp2ooH9RJLZxH57fNtP8kDDU0lB1PnqratSvRnwojqWEQbyqWz83QbHg8cIdEYN+k8yVntgbP8FbzrT65qxcvKvkCzODm7vAnFeJTfn2sQBcdG+M+Su5IFnhskHgWXLIXCIJxUhHqLWm+NoDUOcyJt8qcK1W7N4k7UPfBnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698021; c=relaxed/simple;
	bh=IqLXJi+NouW5dF1e5LZNdeeBHALJvUmJ/AlEHGBaBHs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=putVQQ5V+cbfpwflT6HVuxQ86ZqSY6Pc92viqfVe8aZZ0e723mrTVJbJKCPSh1gV0hM2uQ01Rzy27B54DPfUqL4NUc3SJ+8Bs2YzssBuzNUi1he1EqSwBL4QeCWESeKjnMTtT2n3S4V3s5AwWhPEVuXi+3Kp0qvNjJaToSpe5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQCszuy7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQCszuy7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441a2ba14so2260890f8f.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788698019; x=1789302819; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqLXJi+NouW5dF1e5LZNdeeBHALJvUmJ/AlEHGBaBHs=;
        b=nQCszuy7gdB+7ax1YnyJkP9LW4zY2VxFKxLgHIbdQPBi71jW0AICIkjQeNz9iEE5FP
         Kv+ovhiZ+d/64lJQKxfxg9ev0a8L6L7VLAwCXGcOl+TtUjRwjAdr6F72J0Y5HAmmUTVD
         iaswc/aUY5VU0JtQa1tTvT5Oiv6FSXEkzsvinaAIIrUltJOo4Cc7Q7CX0Dmr+oxlKa2p
         y+dWq43QkNS4C+HqB+O+MCxit/Mi+d/0QU76D7h1R544I3tkCvxHw5CcRf4e1JfjqkRA
         +ekLOVoXeLJIiW0i/C5Xls0y41cJWNCkXkqi6I04O+GA5He3fUU6Rur9APBbfC4kQQW/
         3UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788698019; x=1789302819;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqLXJi+NouW5dF1e5LZNdeeBHALJvUmJ/AlEHGBaBHs=;
        b=lwUO0PR7VfJ0WPXZGBWP259k6rke/8XdR8zEdaqOWhVJ5H4BtKyIjaZjaDJqlpCQhx
         W9LRRQLlw95fcwbRynRZC3rI10qtvRcsiXJ5y9lHaAw40dVW2Hd+AepKIdcA4/0Irxxh
         CFnZwftIrmTkaNbI8ZapCt3ZlJftP73azfr2W8Eqy2dQ4HnfFG3JDenxwseiidPol/LO
         E4tZVlOjBvyMAGVX2d3pG+O+69xXrw1k0OoCrMTZPOnvxKndR9XzPmUEiw28dfBtcj1C
         jWcjObxhUVygJ/vNZgX7eGbyoBTdbv6XJnh9tHSVseswff3bDhUN5WKXNZPpsr2uD7zW
         6Gjg==
X-Gm-Message-State: AFuF++nO/sUvmj8QEUVZ32m5lnJiVOJo/rXAcJNpDBWDN+Kp76fssEMI
	hgfFqg/cWa/RhEA/G/4ndCkqL+vUzOQA00A7LEeJh3rNhlruUU+anGj6
X-Gm-Gg: AYBFou2xYBtB0pZqw4br7u0aZJh91nIYw7Ra6W01xD5up2ybp1koXa2i91doKPeXcWr
	vevyfSPE+qMIVsBkpkrF+ROK5MBVmUVKcFeR10D4i98ixeDNg9v/0IRvtYUbjfcib24owLgf5YK
	LgPvEH46Qm8HATyD0p+AffhJXeuKkC5dn+9d1TeZAjy9+1Lh0P+Rn50miTWJC9mDmAH1l6QkzlR
	xNvvFFOaD2q10hcdCfBkQ3h0v7DtcElTpyZJqdgV7nlTv6kPZLcDZ/F6EgQ1mBgArwvUY7z5pef
	l0qMmDfMSpbGGYcvKj4uh4RTJDhoymicHHY7L8Vuf0QB20w8d01cjJP+Yd9BpR0M66TPGHJoLiy
	h7uwBYsorIcg0lnN22YQljLlej0LULmBCVfiXLCiJsvTeY7kClONEE+ErBpkYlwM1j5UYAkyhwB
	lmPEL6kF6oegCPrfWvm1pViuyBTCrJ9meZ35y4MxlJAz88u/sSPDO0qMeedhhTQh0ueDJGHBPn7
	TEZfwg=
X-Received: by 2002:a05:6000:29d3:b0:485:8edf:8353 with SMTP id ffacd0b85a97d-4858edf8434mr8101132f8f.43.1788698018575;
        Sun, 06 Sep 2026 05:33:38 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.69.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm18016884f8f.17.2026.09.06.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:33:38 -0700 (PDT)
Message-ID: <6a9d5da2.c9eda3e9.76660.4544@mx.google.com>
Date: Sun, 06 Sep 2026 05:33:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Abdifatah Suruur <suruurism@gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/platform: keep logical vm_pgoff in MMIO region mmap
In-Reply-To: <882503c8-6993-452a-98e5-2eb72faff58b@redhat.com>
References: <20260903092927.502-1-suruurism@gmail.com> <882503c8-6993-452a-98e5-2eb72faff58b@redhat.com>

T24gOS80LzI2IDE2OjUyLCBFcmljIEF1Z2VyIHdyb3RlOgo+IFdoaWxlIGF0IGl0LCBkb24ndCB5
b3Ugd2FudCB0byBmaXggdGhlIHNhbWUgcGF0dGVybiBpbiBjZHgvbWFpbi5jLAo+IGZzbC1tYy92
ZmlvX2ZzbF9tYy5jPwoKWWVzIC0gc2VudCBhcyBzZXBhcmF0ZSBwYXRjaGVzIGZvciBib3RoIGRy
aXZlcnM6CgotIFtQQVRDSF0gdmZpby9mc2wtbWM6IGtlZXAgbG9naWNhbCB2bV9wZ29mZiBpbiBN
TUlPIHJlZ2lvbiBtbWFwCiAgPDIwMjYwOTAzMDkyOTIyLjQ3MC0xLXN1cnV1cmlzbUBnbWFpbC5j
b20+Ci0gW1BBVENIXSB2ZmlvL2NkeDoga2VlcCBsb2dpY2FsIHZtX3Bnb2ZmIGluIE1NSU8gcmVn
aW9uIG1tYXAKICA8MjAyNjA5MDMwOTI5MzIuNTI2LTEtc3VydXVyaXNtQGdtYWlsLmNvbT4KCkFu
ZCBhIGZvbGxvdy11cCBmb3IgdGhlIGNkeCBtbWFwIHBhdGg6IE1BUF9QUklWQVRFIG1hcHBpbmdz
IGdvIHRocm91Z2gKdGhlIENPVyBzcGVjaWFsIGNhc2UgaW4gZ2V0X3JlbWFwX3Bnb2ZmKCksIHdo
aWNoIG92ZXJ3cml0ZXMgdm1fcGdvZmYKd2l0aCB0aGUgcmF3IFBGTiByZWdhcmRsZXNzIG9mIHRo
ZSBtbWFwX21taW8gY2hhbmdlLCBzbyB2ZmlvX2NkeF9tbWFwKCkKbmVlZHMgdGhlIFZNX1NIQVJF
RCBndWFyZCB0aGUgb3RoZXIgZHJpdmVycyBhbHJlYWR5IGhhdmU6CgotIFtQQVRDSF0gdmZpby9j
ZHg6IHJlamVjdCBub24tc2hhcmVkIE1NSU8gbW1hcHMKICA8MjAyNjA5MDYxMjMyNDUuMTA4ODQt
MS1zdXJ1dXJpc21AZ21haWwuY29tPgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4KCkFiZGlmYXRh
aAo=
