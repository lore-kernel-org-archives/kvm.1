Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B861AAE17
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561130; cv=none; b=MH5bkSMWd5G3YusQOSEYSmnQyLlYeqKVSpRV+Kb/jg55uASli92AA5/7Ca6UZVe00NnLJSPMuZ+V/o9RHV81D59w78VkSxNS+RUoclQBfFeMlJ/K93guEpCLBH5JrrTKRCzFVbZ/RfNEjozXsIFPQe8E7daZzZW/vT/81Oan1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561130; c=relaxed/simple;
	bh=or3Ds+w4AFk7js/HFcyuysiqVOdBlFel4S3+52ocKVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV0ElpSi2uG6ZSUMOXORmataDqYL+oU1Mr0v30Lslg8eX2XEn81KRavmeTDp6kse0EFkkcBsswSZ6B222aeEkKBt0ZwtDZ1D+C0vMIe33uGjXdCcNFPwESGjQrpb1WCTUhWV288Gza+NutEB9sO+QluG5KgXzMQj7ePuS1LAnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2fNmU6U; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2fNmU6U"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15fc4707f5so22084666b.3
        for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787561127; x=1788165927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=or3Ds+w4AFk7js/HFcyuysiqVOdBlFel4S3+52ocKVw=;
        b=a2fNmU6Udpr1tFm1lBh9rITNnQOCROf75cvy/tQQ7R1DMwMHmi0gAhrk5/8mz6iwzi
         uS9lYxB7pslKrVUcNIxY8h+NIYR/DkiQKk8NzXNJiMFqhmJSfc1pTFNDcS1kmJOiu9r4
         vIgWSFcHqvA99mfEBt70/WYrH5pze+DgtCSKYiL3KSm0DMDF7FINeJDNm+pycO3rwVVU
         mVq8PUKEQtL/2PoZM1JFoDbmNt2KkIx7rUnc4q5tgSq19bSpMfqKzzCqLhF7F0VnWf+B
         QTTXQ5Gk0TGKfi2K1+vXEXc0kW9m7R/eiF/8cPxfmsvpNr0j7aC+U4jylF84wN6DoC5S
         0cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561127; x=1788165927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=or3Ds+w4AFk7js/HFcyuysiqVOdBlFel4S3+52ocKVw=;
        b=sMpgQbXABrBLMJwd1ZRL+jZzhQO1zIwlEa+s25+ZsgUyvdRbeDwrYTBiqVTZTBwlWg
         HY518zJXztO/fTUppkTBjlF97YGvk5sSqU0VSuq7HftIMPOIbJUQ4kufwX9MDoJ138kl
         AgMTxUODZW/B5hAh9SvlTGV2Qos6xfGCxW90B7gZ099MGZvGSdB9/zUZh9W/Ara7aFEc
         QZNOoPJrdAXTt3TQN/i4R9vTKEONrYOBLHulj7xYEaTn1WtRD6GlJDTFp8/zf7u8yhRe
         eTfPlRZzFG4EbCUu/vz61kORLiIB+XgakLS/8LjF3S1GxC/jbqUQXnX0UYSivFepdkxa
         CtCg==
X-Forwarded-Encrypted: i=1; AHgh+RpplNBCSp/xjbtHcIZJEzRNvQL/x8v4n2Wtrgx94CFGt5UGunjtVNaRHzE6wl0eZpdfEeA=@vger.kernel.org
X-Gm-Message-State: AFuF++kpEIrgZasMvgpTwnXBCHnnl1fO7Eld6ruHMkgsUnWkxZgCzLO5
	YJrQySvsNOzDiPsPojXGWQDVXOH0cuHCsLpKRLlTmhiXGkdcS5JWmCPr
X-Gm-Gg: AR+sD13Jt3CBDLqlVz9Ufo+Fcen9l/72SoI03OMWpEHE/wX02wzYMBLEYzWi4AIzE9G
	0q2ax+3Sb9dzt0I+a18CWHfWdVcMT/zEhHfHSy7onPOW5DAkJ6YJMnhLXv3PPM7BojJtfXWyG3Y
	Hqjv7HLWDsrlg+ijCxvX6/YkdXydLqmQagO1g0nfQ5UUC8h0dZVZHI51OauMLQWmggVLYKjSiPv
	N3XrtT82H/uYElpvJhfALZ0r5ANE6XbUY7p+iFZZQ3SNoIILIimFlqbTXh4XxVy1ZRKyKBzU5wO
	ZwBri5GxzlRvFFwwdOt+I9/iIJ7NZ8fJAIgWXcntGP//Uhtefje0dzbigSS1gXDisK+iUl0aFi0
	9QhELC28zgs8FoBHc+HfGWar5N/SMBZcpnkj7JIKT08oU32cijBg5zPH+0mDGHrwVXDTdFZHtb3
	KUIx1YTIByrxtlrAWgIccuQz9lKQDhXPL+A668pR2SA44+1TZU6g5gOY8ntX7ja9AzREHXDn23W
	mSPsi8vw5Y=
X-Received: by 2002:a17:906:4790:b0:c12:6db4:4bf4 with SMTP id a640c23a62f3a-c2469f9902fmr1554516966b.0.1787561126470;
        Mon, 24 Aug 2026 01:45:26 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f6b48sm1163665466b.33.2026.08.24.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:45:25 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: kayracizmeci@gmail.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 2/2] KVM: x86: Add limit check to IDT in __emulate_int_real()
Date: Mon, 24 Aug 2026 11:45:23 +0300
Message-ID: <20260824084523.406940-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802134428.69252-2-kayracizmeci@gmail.com>
References: <20260802134428.69252-2-kayracizmeci@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle Ping.
