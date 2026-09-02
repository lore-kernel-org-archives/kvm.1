Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929D45C6F8
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352167; cv=none; b=KiWZE3+jGSheuzbGwdkfGffohp7bq58xJGNoHwyaGwgTWgXVRwMZJiXrk6HkCn1iEQCGE3qYDpu5wYpXAW8zs+EWF2a7XiEHCQzLATP+idhmEwaeChQQdvV+PxtYdLzGOa6VeuS/t1dcFEKEk4un+CAcZQUKKv2OMurYwHRbJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352167; c=relaxed/simple;
	bh=1NtzwtYKQaKOgL1cmBlVFgv6KA6EV4PoWhjFNlHF8y8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M6iE08l8Zb6B7D6On2/BsYo5rsF1TMXhtJjzcf0pwMNIjQ1/UG1rWIreBs4pCJo/IuIfnCyamzR+5iBNYRWjMbjE5xmMTCifdZeCNypDF49WE1DkrMqqRsQf0ll4zNmFhdcr4GxYhVA1jG0zROKc9TkrRNRFunXPXjXtI/46JpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SemxA6EF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SemxA6EF"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so118863866b.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352164; x=1788956964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cy2ECIsq8T9hv0xK8mqusI6MnzK8ei8bLe3jiI13Wy8=;
        b=SemxA6EFJ3oox1RC6U/xY0F3HDnNa5CB4upNn08HYSTNF7EWiRxiQnQqYnFgEGi2Te
         KnTEG9nVgM5RvMr01Bdijj+dHyAPGAbplWjoT1bONY7/ORMxbhb3cWitLLvLWXXYTP07
         v8II2/REP5INvBAHjHs7QX75Xy2n5yQlx19TV4ll5b5UlJ947k7sqHovIAE5crrfdVjk
         h4yjVX3h82j3KDJPqBveVrWBUNSpAcKwlVzdpdNbFH8vjfw663WGahdseAWQKVRPhe0m
         o5dU4iWDMyxnUcU85xCzg4j8bdn+M6As2aqbrSXiHjhvyqSh+QS4jvwP+YA1RxKVfKy0
         0MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352164; x=1788956964;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cy2ECIsq8T9hv0xK8mqusI6MnzK8ei8bLe3jiI13Wy8=;
        b=faJeLCfLIusxC3oBVRG78cl1Pza3mjwQSJHddW9DFGXUdbuZe+LCWnn202d7mP69lP
         Jqx3eVJU65vGyhYjkJ6PiNg7k5dpP339P7HVjeWOxb/uoS30iM0Km8076DfLh/fWbcfD
         0wHYeAbfYf8ffkDv77zNNt+KTqyZRRaKk6ppXPtENtn3xgdZj9tA/SDvC3gsc5oIIxoi
         BbnHdbvPesFOnvQezIN6JNNO9Goj29FeWKV8X6CZnRphg4ynoftQ9YLVdCnremX24MMM
         TIwHBVumM9kf6IP+L+ca6AaK9XOb8nbpRHKn0ZjZzGJOO8tA4BqUb//sjdQfRpCh8g7I
         k5Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwtDwDabdmZ8nDKabRMWOVMrIoAQ7V1UzYwvB02F8Ehe8NojVoO4IIVhtXMW7mu2YQtMMw=@vger.kernel.org
X-Gm-Message-State: AFuF++lad8ENYw7/4h1CFZkE9vw4kwxnfSRHwyLJ+fL9txnck5vTdz3m
	+c6bJ9SutkoFed74Y7OnYUdeE7O/JSR88dVqiFtbqB3fdpxY7X+1QBW5
X-Gm-Gg: AYBFou2/I2aZEsQftfE2+7S6Di9CUCuzCyjg/z3sb1ov30nmyHwjaCFU71fgdiiYxyi
	C48wJTYne/cXlmjLt0YpBTOSwb8KMKtx0E4jbFB7FbiN2csGxPP5GCeBvWYoz78gmsq09jBdU9x
	5MTiABURm0vaojkagSg5Rut5i9AOYxOiQlT2JSrwJMFobrZEMmnNVA48Ad2fFUM3xRiPgpOLeSS
	C1zNy5mdvH29O+FiM6Nz7wVTpH7warYhESJhNP02LCnMqgvlp8CPpERO+R5XWf7sMc5DSuLTk5x
	r43w+ROUHJSTFY+FFJUFtMmHubWJenBPs6iPuyNsiDXE5IOD0bddvCLsGypwGid3uUHwcnJhJGv
	VnOhilNYg9NqtZWdYp/Ob8NrmAr4twGp6HP+/5AatwTRm0nSduwNMTzSCmD+SxJi7usmuBN+CiN
	joxL7d4/fm2J0b8usTY0JAywXij67ModSXx7CeV8R2HB1la7sFhkf2E2lKCYkZh3OBmmY8Dqzdt
	C0=
X-Received: by 2002:a17:907:3f9b:b0:c25:5344:43cd with SMTP id a640c23a62f3a-c25d52b3796mr281561566b.7.1788352164261;
        Wed, 02 Sep 2026 05:29:24 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.3.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cfd9c404sm123403066b.0.2026.09.02.05.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:29:23 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <eaa5cbee-6ac5-48f4-86ca-8759ebbdd7a3@xen.org>
Date: Wed, 2 Sep 2026 13:29:22 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] KVM: x86/xen: Enforce 4-byte alignment of
 vcpu_info registration
To: David Woodhouse <dwmw2@infradead.org>, seanjc@google.com,
 pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 ankur.a.arora@oracle.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com,
 nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-7-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Xen's map_guest_area() enforces that vcpu_info is aligned to
> sizeof(xen_ulong_t). KVM has no such check, allowing a guest to
> register vcpu_info at an arbitrary byte alignment.
> 
> Enforce unconditional 4-byte alignment regardless of the current
> shinfo mode. This is sufficient because subsequent commits ensure
> that all locked atomic operations on vcpu_info fields use at most
> 32-bit accesses. Return -ENXIO on failure, matching Xen's
> map_guest_area() behaviour for unaligned requests.
> 
> Originally observed in review of an unrelated patch:
> https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org/
> 
> Cc: stable@vger.kernel.org
> Fixes: 73e69a86347a ("KVM: x86/xen: register vcpu info")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
> Assisted-by: Kiro:claude-opus-4.6-1m
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/xen.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
