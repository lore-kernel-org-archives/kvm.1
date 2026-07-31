Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93714381B07
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528709; cv=none; b=KYHZUL2xL0Ha0BQ1sAWPdbBKKNACMC+5dOCyKBWzloeWg1ZAlJcnXyMZyU+qlqJ+vGztZvVtuMz1u1lqEKEXiYftU5cXVgkJgzH+cMsvzsNXxPdCBCCrRHyzrciYeGoGmDbNaU922MGOlafwOYhSl1YaWUYPM0+I6+JDB1BIuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528709; c=relaxed/simple;
	bh=33e8ObnVADSbfFZgUMyvgoQvOwBUQ+VNku56S/k47s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJeciDHusi3comZGNhfvWpTjbJPEwoF4ozAPAp04SWJrYlVkaTtQ9VvbRdlS2rpEHN5zxibQXmS489U90I5cp0ltwjcGN9paW6FO5ibtcdlwS3QxIgYTL/DKqWWu24dZXcnX7nR0CGDZ6QrlSu1f3fT3TTcXncx59B3QWBCyhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ob7+dPIp; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ob7+dPIp"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab041eced3so2020030a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528708; x=1786133508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxmXIU2iY4wJrhpgJP6fox76TKpljehd+FqjXTThCRg=;
        b=Ob7+dPIpFlKpe7Ne++zSPvBcrkbuLIXB+tkm6wEv4Rr+tVtzJ1+9R+EQ82D4sOSuBJ
         j4eh09Ni8tHDB5tJQg8LOL/VLMGE+XD+0tkCLxVqnxQhREiTOOD0oTWoFuQwHkZcFY2C
         n7WEP8koDmACJOQeAM1m6Qsf9NR6qSk6OwFRyFbGuqDI6q87heESDzwzyHOCnl2VDWcN
         mOajs4tCqJre9whMA69MSa2OcgnLMLFp+yrcf5+7zbSSmcdeOz3KkvFaeIFt/Hzt8Goc
         xclWEGxlNx7h1IAHriHiV437hX6L5gUdQlf3Ty6TFU+Q34elJHgEbhCYpsg3vnbaBhim
         CqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528708; x=1786133508;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxmXIU2iY4wJrhpgJP6fox76TKpljehd+FqjXTThCRg=;
        b=EzIAI+LWEkSfkpJNkS7qaWyZII9aQm90rqxktMpTXlL6bp5fN5Ac9D0NY9jsKfGKwO
         XQm32S1zrw7/Q69MmAl+CQhWPxDkcdIE23968eHuLbFO+lEytQudAeuiU7EUbw/KRPXA
         izXypAQz/HDC/4gLAe2+hoq+/HXQ0sPaZ6u526A3rpizNCjJ8W2VRr4CuduEN39y106l
         eDe9+mBsPJNa4OERAeoiCS9I72vvpFeVOQgLuoPEQNnTdWRj7iXjmL6BEqsjivA6a+TZ
         PYEEONrvphG61fke35xyr/fiN5gyw8XkHxu5bjPa8OriAr/M/Z67DwCPvvCbe89m5ZEm
         i49Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVF3frlLgof1E89aKbx5NX38aXJFlYS2tN0/HJZhh4bxUDst7c3UEVX5cuAzLoQCv4olE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bV5BJmGuOK0VrnPRDlltf0cSYLX/PHh3Fl4MbNJvw6XOMv5l
	Fitg7WTN/4GHfISxFraec862mh41in1c2mxIwvMERLK63iA8RR6w9D+RvEu9c9nHjgWahYQnlDI
	i5uMg5A==
X-Received: from pfbfi13.prod.google.com ([2002:a05:6a00:398d:b0:847:86de:a817])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a9:b0:848:63fb:fda7
 with SMTP id d2e1a72fcca58-84ee48cdaddmr811949b3a.44.1785528707582; Fri, 31
 Jul 2026 13:11:47 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:11 -0700
In-Reply-To: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552822130.2706707.4814565423555232517.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 07 May 2026 12:22:24 +0100, David Woodhouse wrote:
> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
> trap, but on SVM it was not always intercepted. Unconditionally
> intercept ICEBP on SVM to match VMX behaviour and ensure correct
> event delivery semantics.
> 
> Add two selftests exercising ICEBP:
> 
> [...]

Applied the KVM change to kvm-x86 svm, but omitted the selftests, at least for
now.

[1/1] KVM: SVM: Always intercept ICEBP, add INT1 selftests
      https://github.com/kvm-x86/linux/commit/ec9a16c6aeba

--
https://github.com/kvm-x86/linux/tree/next
