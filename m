Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257187;
	b=1kfVqyyazWhuYxDjM8Y0AaxReK1nx9WDZzcZu3xbHyAb9vEBtsix9T1m9IsNrqLjeWFI
	 7nDt2pTuxmr+VTs4LHuM7WTW/2MCn7Dp+Wmyco4Y07oq0sC/nzBeWjVvo6wb2iYTnMzAR
	 zpgVTaMVWQBSNZVOaaeLKHQMSIXu6GJ5Q/zuweD8+YcSkBwFHt38K48jVTz126SYQPzuA
	 OVaGbRxqoCE1YfnapJWOCjkVQ1wMz7aGuFsjAz6GhWertjG9WyhWXuHzECnVhpXgMy1mU
	 1u9JAK0+NW1ErR+TcEzMGuopdDxM9GCA8dt65OTZ3+gx+yTfGU6DijdzpLK/dGcncNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
	b=RTrnAwFPqyayyEsUV+zFsbTviqyijPydHgU3WAjWE83hI+xBzfYgNi6HxKh7Y1uROzuA
	 FkhVWP8VTehTUx1H73LOoD0RcEe9sC1bTqvFbLgEU8IXCtkHFVfVDQPVwHfCOM17b2RqF
	 ljQ+lEQvWWt0uJVtNLL4pwWxgfZlms3gYycofI9azxLAs2eJ6NB4kSG9m0uME+15IGyUN
	 LYjOLG4AbmPmy/qehDqXDtSis5M/iVArE/n/IJ9A0lt1y0M7YrJ95T6ALDX/x99gAmc3Z
	 +YkwfvKOqc6FbYzigkpVEcyhzKdjEJX+b0EIRLelrRCQs6LdyC09QFq7LKu6U2s5efA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjmbIVml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A7606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjmbIVml
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso467a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:46:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257185; cv=none;
        d=google.com; s=arc-20260327;
        b=JmXYAELX+SHApbDHNNocuA5F/6jEEuCRWi+gfMuVAoOKEG2hrpG2hrp84ddNaZD6sQ
         aHCZEsCaZgoX4W3BPi81KyJzC8WGKR6tHMmigenlHbk9iZ1zJxmU91cxiyXwDfw3dalk
         Ie9x7MEZ9t0beqY1iNWfW+aluC2laYhqHCzsfYmqrA2O6dnqgybCGi3+RoHlVmx5IoFX
         vV1X6JSf+Dc4K4TYwVHvOIQDlXWDnw4L4ZvaU+m1agfuIXMXgDt/ktRUuKVTyAnwRq3y
         yzbhXuZ9h9fULESXQlFPzj2hAt/UCK/JzbwlAqaA4J9yzxEjXpX9YNxiGqhCKQR9NH2i
         VEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
        fh=rRceochxK0ybon6YNgIy7hp8wvvHngpKD39+jYn4qE4=;
        b=MgmpGhAL00IcEv8l5+mIXdzmByBQuhtClMP8DujgMA6ObJyRUqckRqzS524eymkiWO
         8w1j9GQezmcRsgt8vBJwjImeAnkLDOrXfvzExx9ciBpuGn+hpZalhGXMjIGuyWUqlTna
         SHKy6W0S3AfNivPQe1rk6CrN6y3wVgoq+dWNTrGanerq3fULplqGlQwAhlUqdMBDcumM
         /hYxKijYS1fbH8ymBDoFOa3EPk9zIsSN1mqiEvu2KPrCDFDKe3I8Skr1oCbfJVwaczjW
         wFUEOS0uwBmyfe+FPBdoxMWH23/bKSJ8+AGSv+XWlDZ8PdiKA7T8Q9KVCLnJknyMITMv
         Agaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794257185; x=1794861985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
        b=bjmbIVmlVps47DxU2dPQJ5pwJaNAF41z2gZGi0YEhfnTKlEqYoe57e7OWhUprf8Z42
         1HAtkClj5nNiDYZu/jrpi7vRay7OXREVKRwDoDcvWUn/gOk7UTJ5K7VXP0QdpcwMeWYn
         3BtP/f/mPblwFKUL2n1Ol5RGnZ3UXXJ7PnCvzaqCuh/Zf4Ve8Og9n4TjHvReyz970nhR
         hQHRZWbghhz728nParnhAANvsGxZzjsd+Cw+uZtYYxJhXGaMETAuuGCaSiJtws8Nc349
         Ckr+gG6bQ7pgroujjf8yFvzVSwv4PKf8RnT+zveMMB0mOe2uxd2RAku7pYGsfK1IrAHQ
         Ok8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257185; x=1794861985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uu3K6wTNGgm1zwzwRP7EeiHq4On5xub2lepnKvIKm/4=;
        b=LCn1i25eElXvB4qGsJaJtxVjDD5LEQqmToIwv+WA0bvfBmD7UoE9j8ZPebOjFaLK83
         zjZitGUcCYa3Of2kooQdFv/aZG8A57OFs2s+gXrrDd/jPDXFPGra4bL/xJUGuUvx68aW
         3naEDgM49ASRhEuA9/IuuEkUPV4fwAJa8MnDW7wrIbVG/q1p/vEnpQRrhjb6otXsn8db
         QKfB73t//lgaL8ndSMbNmw7xcRCrcC1E707DowifF5opD6rCwJCAOQ2XVmIYUPocanEw
         SF1Oq/G7UhqmcWC0bKKIYs1s9wNeouSW355hlgbfywdSy7NjeNte0SJKX1lomkIVzllG
         xR0Q==
X-Forwarded-Encrypted: i=1; AL+hErEIW2EGoaYL+lKAZfSKec07UtyWkpsnMo9ScjhILOl/OBEOZKgyRSjvkkLSZUr0I9TNe7E=@vger.kernel.org
X-Gm-Message-State: APuU4Z80WVdFttnb9JG1eboGNa+3dxO23KI/zFKd3Y4u93wjNdu2pjz4
	7B9bfCkNYot6XuTLJD8QpwZUDrzQMSt87a7JFxh0ALFN5VXDel4Up5OUPEu70ernk/qwhpUPNjl
	JfEyCQ7xGK77oW2MwRVQ5P+mzrd0USzHEaGyIYSs=
X-Gm-Gg: AYBFou1xDupRAS05AdQOvM5QpYEFPeIBHQbet4rZFMOOUu5w02P+gWl47PgLsH7jQub
	jUa2hV08pYL+Q4YW+FLJIREoYPx/NniH5Rr2MNM7jBVgUSiCeUJZzAHaC44MVLgaWWVAXCNIwVL
	E45MzRUFS1hIkbB9zAJUM02VT/uN9VBW/lMjQwMh+AHeUgEDWNZ/O2LD6KAf3bEhyfVnThigWF2
	rt/0K9xg2JM+7bnXFoFvSJR134iF3AIpt8JmUUNkHg1h3EW34K5evKndLE/MSiU9ZOhA/nv+c7b
	hiL1t+6fbMKycq5ROzQsHl/SXPOYhjsfD/TufVz+6wVHEHZTZzDatX+ka4F900Eac0e+JDxBOD4
	0PfILpL9rHvgLHCYNoV6tWr+hahw99JQW4fjHTW8+h2Qj7+t7MacmzRh6gD3v0qhTFR7o
X-Received: by 2002:a05:6402:230f:b0:6b6:eccd:ce77 with SMTP id
 4fb4d7f45d1cf-6b75a42c3cfmr6765a12.9.1794257184735; Mon, 09 Nov 2026 12:46:24
 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 9 Nov 2026 12:46:13 -0800
X-Gm-Features: AclHuK-EaKTK_W3z35T4yU7ijGPbdeY5ooy3Um9LzcWXfKIxay3zuRepOxUsniU
Message-ID: <CAJxe5csfx5Ubf15Pw4Mdk03tmEQtWxN11tfwY3tv006k-Nbgpw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Protect VMM from speculative attacks using x86 PKRU
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Reiji Watanabe <reijiw@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, David Kaplan <david.kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"

Adding Alexandra, Matteo and David, who may be interested in this.

The full series is here:
https://lore.kernel.org/r/20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com

Any feedback is very welcome. I'm planning a v2 that addresses Dave's
comments.
