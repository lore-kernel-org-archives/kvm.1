Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97326C3BD
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345625; cv=none; b=EXBZMu0r15X/TTydQiYntZQkj13FDvQj8r4PMKLgrXgBEyOPPH4QqFGbIYEKlsOWpGESdG46Q9AcSMMXP+Rk0ikNqsC8z2aS6/P5URw3o0NtsY3MOqJuQ1Dc7EfMFisBzI/RBzIBHs95ZuJJ53MC5/Y6QUECPoqguXemP4yt2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345625; c=relaxed/simple;
	bh=yx36+WojFqYM9ZBQ6m6lheFZOEsenIDxuibwk4DnuyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a7AF5U024D4S53+4o19ILeV08UeQ4EahRPAjI0i8dKNDEcZdYIhp1M749kM4CIXhEImMHelaVqyEg2l07OZa+RjCRCVLfk3CFH7W1IDxLEM6nzxIYzQ1z3w803bCfv3KAW9ZXbnWWX1SuqI62T0AD68JA2IzTfBZlrp6GgMY4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Cggo0bH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Cggo0bH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aea7747aeeso15697895ad.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345624; x=1773950424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx36+WojFqYM9ZBQ6m6lheFZOEsenIDxuibwk4DnuyA=;
        b=3Cggo0bHyZGbZjcflfFZbcJQScXCMF8lxzcYVRvkcY09oYjIq6bnE8S35e8iIo7uHX
         rd3olUzfqNDvb595uXwxXI9VUSFoZWQH9Ohm+A43uke3aGKHGvk3D0wti16NMDx5ZUEf
         bgZXKbmk7ABWosvpeS9bGvYHd+VflOnz+mYIwBGtixMlh5COUkFD6TCx4xNaNNJRTphq
         OW/XI5F++HXNNJn0m0xBeCyx+Q4/CcZa0ySHy9MlL28nttq743+KzDZPEPUR5C4X0+eZ
         icqzBGcdNBH53WG7SCXEYLUSKrZWWfhvhA8weD1iQK9ugLlMukLMATqA3jCWFRt7d3Qj
         0D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345624; x=1773950424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yx36+WojFqYM9ZBQ6m6lheFZOEsenIDxuibwk4DnuyA=;
        b=WHIx20Jsq3iaC5XCTFlt1ubtaoO2QSTifr0JTMPh+exGYuzfPAl1hZVmpdlE4N2UhW
         1UhygHAz3SdWIqKuhxmoiHJl9ggLJOjsX9mpT53mMBYHjZYX7bQWzNLSKTGn9OX2cXZo
         Xsb+daQdYA24DBqxuFBEuUZ0v2CruO8PamufXaJnrALTrJUgmb1Be7nY3oTnFwlhbUZg
         b+XMmk5K28HpLEZVrciWq7bVVaXqW+MqHRhXwpjqOC4NS3d6b/Ten0EJ4aAlgbkFLP3g
         zNE2eemyOQpF49pwj69VD7u5myxdzjQgCQT+ibvPZihToJsAOcukkjSRlLQNmjfy0A8+
         0X0g==
X-Forwarded-Encrypted: i=1; AJvYcCVZrLoKvMKEPg/hrNiW4BQ35WrG5P8zcOiDcos/OYcjiK9jyvEh/Aj6f2A471YFDlj3BKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlD5nugRwmZwuWGPKLmHXBWwZ4kB0jBS2h1uggO8omsuHmGmo
	0M0W94LW2Ykhnd4pK9vv+yTB3zmS5SeqWWMgRvGkcW3E2kDQx+2RpbyD27nZOqhetlmX9bBqcDk
	s4VWxvA==
X-Received: from plbi18.prod.google.com ([2002:a17:903:20d2:b0:2ae:47b3:aceb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94d:b0:2ae:3afc:eb38
 with SMTP id d9443c01a7336-2aecaacf9efmr6172755ad.41.1773345623956; Thu, 12
 Mar 2026 13:00:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:00:22 -0700
In-Reply-To: <20260303191509.1565629-6-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303191509.1565629-1-tycho@kernel.org> <20260303191509.1565629-6-tycho@kernel.org>
Message-ID: <abMbVi8zTgt0XaE9@google.com>
Subject: Re: [PATCH 5/5] selftests/kvm: teach sev_*_test about revoking VM types
From: Sean Christopherson <seanjc@google.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Shuah Khan <shuah@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM: selftests:

(though selftests/kvm is totally fine, but since you need to respin anyways...)
