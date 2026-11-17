Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948230;
	b=YDo08tZ6gnj1/9lg/A8Po7EWq6SVdf7XsHhQLa7eataz111EU1WJSM0bJq9Q6/bs5d7w
	 b7n0FSn5aAsGxjp9HtyA19xOjSkntICeJl6ka15DDuYbG4o9tLt02BRzMJ00lctTVV7zQ
	 1NpPDYyIWVwlKNgJLjNolztzG//vFfrsbc//gBhwSj/SP0kNi86ZIsy+it2Pft7uB6utl
	 2jVD7TqiEHervbpmb+7iFK7nkPVWXGQYUzM+m4IDjNuAm1aGp2HN/kta1jzByRkwT0kzE
	 tfGaepMFEP9trsOpy8B5p21h10wCKoWR7RQrBIDyoacjJgpK6XU8DvRQr9SrEqVDsdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7+VP2e4/Jx1gpeLV32IskoHLYhFefIx3VrQoyhcc2vQ=;
	b=nQltxQZERCOaXu10+baqU8VCGjnhH5Z63QFndbgp5ybrLtMqYV7GKmeZQ1K8UTWiHqBt
	 knhRoeV+Bu+57Z580sA5n7+ATn5ovRQVQlWK1TQGXZ+YLRoKybE5QmDagN3+PBq1wLsPI
	 ILyl+yi5G3y8s2OOvJPhLuxjMvvhyaRejJu1rk7iJx8MO3HejEfUVxLxT8xLs3I2B84oS
	 RI4tZhF0vBUCcrZKFTadkYYbXiVaSGpUgCuLRFSpqDEAG20fUg+uCJKuZo5bItJ44R4wc
	 01N/tUPoh0IZF5/NCmntSjPgXvB6i0yEECMyoAkslteMtaGTgmM48JgmJvJ6f+8ARXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lqbpY5GP;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645E606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7645E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lqbpY5GP
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c7f887ac6bso166162b6e.3
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794948229; x=1795553029; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+VP2e4/Jx1gpeLV32IskoHLYhFefIx3VrQoyhcc2vQ=;
        b=lqbpY5GPvsl7zhPAqUNihZIL1NAVyyEGEX/qnOIniGI8xTvMmxNSHu2vsK7I4lgg25
         0oJi6dkbUV6+GjUh9aNHRHJ9I2aBTwc5FXR6xiqpKyGZ6SgyrOzf2CkEb3nZMfDuf675
         sDwE+apequohwZHdSJZ7FYuW8CH2Jzv5CbQOUHhgMYdGr3bxRdgl1it1d2ifMFN+imPP
         Dids0Ns0ll8XachZAX4Jz5yKXKz7HjyezbHU7mQ68lAs/MXwk777pYrgZldcXRTnosgP
         16hRAp+3fg028x/hpGt4S37dgc8NRc5Wr24iHZdtC8LJX1t2IL05tcfE8wTberj4e+8J
         kxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948229; x=1795553029;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+VP2e4/Jx1gpeLV32IskoHLYhFefIx3VrQoyhcc2vQ=;
        b=hiGlxMSTClL2e+l+n2o2LftYeAs5IikVoTzcFjMJrEjgdMdZNsMnOqmP5YEYGV0Wq+
         xhuDbzT2yBBFRkv2rOD/e0dOWM9t2/6WAU6U7OLT5o2r8G+IVxQ+KOA3X2erZ3paSmAa
         6IxKeqcF+ntX0bDtQRToCr6Jjjim8mzpEV310Rxnn2TaeTaSlttWdw6AqOI9wtCgt+q8
         pdATkNoCzSFOk0yPwVVLvpISUwumrgLNKcC861XaaSGhebl1rOa4JptETi61r5Drjnr7
         6gdUOp5ajGGRah6+EQ4Bt7+N/a6n1x+ttfxmgfnGb2L/bswP7z0c5JaRSIAdF1tKbNWB
         z+WQ==
X-Forwarded-Encrypted: i=1; AL+hErHyhVu+Qr4IegzEmvEHHB6ZRiX5zbGlQ/hv5SeWyxiyB3LkmzIKdeEd+duS3M68353DSCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MFomj4+PJlDkcBX7iyNbaM6hcgRspOXNj4TfCzejdkMTMhTCw
	yam0/zJxiAD/deEU53fPLh8MMe4HSCTBdzheqITZl9HX01lcImWHHjbE4TFqIVxLJm4C1mhjbQi
	Y9lxoc3ZinhbuemQEuCLy1xagYg==
X-Received: from jabha52.prod.google.com ([2002:a05:6638:6bb4:b0:620:1989:fc1c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2384:b0:572:72d4:9ac9 with SMTP id 5614622812f47-577424093eamr890686b6e.27.1794948229188;
 Tue, 17 Nov 2026 12:43:49 -0800 (PST)
Date: Tue, 17 Nov 2026 20:42:44 +0000
In-Reply-To: <86fqwz1udi.wl-maz@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116200418.3535619-1-coltonlewis@google.com>
 <20261116200418.3535619-3-coltonlewis@google.com> <86fqwz1udi.wl-maz@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261117204348.4020440-1-coltonlewis@google.com>
Subject: Re: [PATCH v1 2/2] KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0
 when E2H0 is NI_NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Colton Lewis <coltonlewis@google.com>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Marc Zyngier <maz@kernel.org> writes:

> I think this is the only reliable test you can implement.

Thanks, I dropped the guest-side HCR_EL2 check and kept only the
KVM_SET_ONE_REG/KVM_GET_ONE_REG test in v2.

-- Colton
