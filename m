Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577664;
	b=BX8ayvU/iatfOBWHkv+nvGY33g76visgDmcq7L6r+o9fdOvczY2bFrLkTRh/WjzcGLAC
	 UcODJ3kGX/YlB0FPERBSJnqAxphT/ppOzwSQ5KIfCqGi8N/eYt+ZseSF/8yYWAH23nj4F
	 iKg/rV12nwpUCfpV67ZcZqHccYam9db2sOUh5/XWcXHBKJIUBcbah1VrWv+jh34/RcGMP
	 Vd65o809pYYojA9NJN3cA9iBhc2vFsv57BdJnUb+Tc0UbzU/haox8AmsXA30J255/4zj2
	 pgXYxmBbfDJVo20tFlEA0ROI8YK70L16dSt9RT0Jw9752gBSym3P+eZatqQAam7FA5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=58sEe0BHU5Au0xisS/lqaZE010aQzkxa4/+2f7HcCgE=;
	b=u5UgNz2wgh5weRCOTkoA3rBr00tE+3I69t8/+h2/8G34JYYcui2vGz+Oq02DVkcT6xwj
	 DSQlYAx/VwcaUU7vMDV0vAt3VmGczsqAQl+S6uomA0M8fYzXroJgc+5E9Wg9Sa5lrZA0q
	 ydAs+rs4LchkTPJSEP4THt4fBxw3O/YURfvR6md2T+Tnj6ivhMSr8RlgNycn7Uz52FoHk
	 m0DF0c5Y9cvgLg150lbTYqYX8BCDR9aD+Z5ki3oAZcwSt5wWbdExTSvwHPIhX+WF3FqE4
	 3zLsT8Llvw8RPV6NZdtP6jwNiN9TR+A2XLxTiVSt4E2PInSWVYY8AOlMtJk4asRS/Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2PGJZqG;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5A606A32D
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D5A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2PGJZqG
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so650296a12.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577663; x=1795182463; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58sEe0BHU5Au0xisS/lqaZE010aQzkxa4/+2f7HcCgE=;
        b=l2PGJZqGYxvhATo4F1i9faJA2f6ya8Kz/C8VrstCvC013HVx6eydXtIa//J+Vho4nh
         /U1Zy+Hw6O1g+GFO7bCWGTIaTkbERzE348WEtW1ubNS4ubuIyWgsZdRAxW8+wXJMjppp
         EPfKra56aTtMeQVuR9hl+pmOuw8u4GBEv8bTHQoJxciUWR693GN2hU8S58qVikYt3ZQ6
         EkPIMDumA8N/8+hDB7V4PodqLrOgfKgoScwoGaJnlC9jqeeBrdkVJ1tH9SSXoSHJCtCw
         lKQusZhKnbc5rptUoZQQN2gQS2g7unyWxW9oFOXtN1PbM/UPPeSfavdVNMA+CIRRXpDb
         s+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577663; x=1795182463;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58sEe0BHU5Au0xisS/lqaZE010aQzkxa4/+2f7HcCgE=;
        b=0xFC7LAUjAnnY2lmdqUDVlW958+mSXeksaXgcbcIpqM/0JTMpCTCujUeqTwd0TGc3c
         3s5op1sYFe2lD1sLX5XW7uUyHXOhu8VqtS0BArVr8dkWlRepvxeKbbBt50Z7GQ0HhiPf
         uSWVk4yi/lWsbESH9Q6V3805yCAfK9vPwh5U3ae4drUV+akkxcAQg3yfXyOkrZQYuOp7
         Cz6B8plgUnfMxR+vxcr0GyAbMzsy35ujGua3mPEWznokHIPWdXl84rWNb+DmEDzGZ8YR
         PaYF2TU15C//gWdJ69R0RHp5Od3t2Y8A7rYjCpklFf5au7CUKkxb0eLM0RFKSPzuyLzx
         qn+w==
X-Forwarded-Encrypted: i=1; AL+hErH1S3rb0GRBulXAyHHS1Sx+th4xVku6wRXWpbqXgv/+7jFtPWGQCYzg7UN49l4RkSJIFUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jnn05/OERSVmry/qF7XBUiletH/4ZuVUmpXVVVKMG2+HD1qiQ
	+Is2Huy/gPE+eyFQJO18E4bOv39x0nSAmxprsE6jcrjSA+Ws/oMA783/rK5zOgT7RDXj6FsLKgr
	AqJ50+Q==
X-Received: from pjbgg4.prod.google.com ([2002:a17:90b:a04:b0:3ac:7545:d82e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c7:b0:3ad:9ecf:2b88
 with SMTP id 98e67ed59e1d1-3b1b0a0b8eemr2120104a91.19.1794577663138; Fri, 13
 Nov 2026 05:47:43 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:16 -0800
In-Reply-To: <20261014200152.1365147-1-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261014200152.1365147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441826288.81035.4880834403901234629.b4-ty@b4>
Subject: Re: [PATCH] KVM: selftests: Provide empty installation rules on
 unsupported ARCHs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Wed, 14 Oct 2026 16:01:52 -0400, Sasha Levin wrote:
> Unsupported architectures provide all and clean, but installation and
> runlist generation fail with missing targets. Supply empty install,
> emit_tests and run_tests targets alongside the existing empty rules.
> This represents an unsupported suite without creating dummy artifacts.

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: Provide empty installation rules on unsupported ARCHs
      https://github.com/kvm-x86/linux/commit/7a2ff8e1f281

--
https://github.com/kvm-x86/linux/tree/next
