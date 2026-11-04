Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833440;
	b=l0uoICT8jLcuV0ltMjCZZe56I/5FoeB+F7cW7njsNuKVvS331PBFTMUsLPNoHiOzuqlx
	 CotRF8ofXDpkm2y3hfElcfJGWiPHtsZJ6BsfVVyVWphr9Qk2TuflgYn6JXL1aIQucNJDh
	 a33G4FOAVPe8lT/2bLDVsrPT+Q9DMqCKLJCZRuzy6YTOjTlUoudsk41sl/cu1jXuH+C58
	 ZccjQpwgJG75cdXFMqJQe0DtjrcvQ2imTb9eVLyIZnehfui2n/PWhlJ2+2N2K4/OGVrI5
	 nfwUSM4rH21NTt+1ux7ouPLZNGdZJ91KgYxuflN/SV6nCNzMucw699L7SQCUzx6GPxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2wbReRTlQJBCUXaK1+7DHFjdOGAtQHERTJ//FRhbpjw=;
	b=nN9miaHk6MJcxIc41rwL1ob4wz65+yo/JljvCgVhwrYyDds14F6IOzIjrIQDvX79VdfT
	 SnNDwA7ifR6I9pIUsJmvHKp3kF9mpigqb0KGOKTi8QSsULjL6HpulEmGQJFnrGqtOWP/Y
	 CSEzkMAhhfzZSBR3UUPwT2XDxajD4QcXk/fEMS75F8nU88E8C/h0tHb7cVxVaqp+fo80o
	 J/SII6OPLK9tLLyD9LpcMAdBI/nq0u3t2rlnTAOihtMDWj7iCNHgD5Tc0eojnxxfhilFX
	 SENdCd26kKlRyokyAcsCyPrg5RnQfGrzCGmd6o4wEn0L9P7ACcD98ail3m5vBRZZG5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B9606A333
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A79B9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08904845so16852715ad.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793833439; x=1794438239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wbReRTlQJBCUXaK1+7DHFjdOGAtQHERTJ//FRhbpjw=;
        b=cfcSO+zWhNbJhxmkGimeY3PEwRA9X69/Tgx0y7TqHxcHiVraVBh2fd265reUdqWrdv
         gHt1i1xZ7JdHt0OM8GlDeMdrTf9U3qCEy6OJ8WVX0N2nxVIzMttSryWt3QW1Q3K/32AQ
         HU/w5lNCWTBN2QHWVKnYglIMlxD77Xw8vQ65DCdlsVh2h1NclOWFNlco15jgnuKFgWc9
         EMILZ2xQVI+CIhBdy7DRuDx4XfTPz2XXqsLUXrkHPXPsSCgqEq4iOfkdq6DKjq22dt5H
         CKpDArEDLejZ/7xG/VAdmjtRKfIZb4aPuREyhvDecCNIAB7Ub+BDW2jj9aL9jQHdO/id
         CTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833439; x=1794438239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wbReRTlQJBCUXaK1+7DHFjdOGAtQHERTJ//FRhbpjw=;
        b=aQZoQ6IHpU3P2gO3uO2pMXxAIom+WT4DDclLWV2ik0w3eKCw+LOo2wQeE2k/1scwRL
         eQLNlHIJoICjGTR58xYCy1B1aPOg5EVri7giztohPnMcYKFbxFvI8KILTO5mvvQu+rWU
         +7CJxHubSyyRQVDP9oI0FKrg5OrFw8faq/b9ApI/S1Nw1g7hxUm2UMd7XRFMJp0odYjf
         ws0gqSdllsLv6RcOlAc+HYl6jTl3Aia3sPSxSzYftQPbaz4KwL/N317ZhI9cgrzhJ6pQ
         +lK9uKsXzY9YhQA9A/QErRo2OuUKlsRfG2kHu5rz7/Csaqhjc/NpBoPJqUdI8Ew+APZm
         i/Bw==
X-Forwarded-Encrypted: i=1; AKwUvBxzPVjZ6OeFBK9e7Wk4zEYS+Nc77ytOBXxh3I5o4aU3XxZVDuoYihrUFthgPfmC/fkJTG0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pQLNuRn/yfQxdBOjlrJYGigeGgxOQbBg8LxpHilrb1Tgvf0wV
	4Fxi+/lJzSUB21ERCaj0OkpgYKa9DbCCO/3qV1oqEUlKlymw5dHLfNnP6bIAkcH/gPXZB6D0+et
	c62+/dw==
X-Received: from plgu4.prod.google.com ([2002:a17:902:e804:b0:2eb:3675:626c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d986:b0:2e4:b112:14d
 with SMTP id d9443c01a7336-2eb3651ef90mr147849885ad.54.1793833438788; Wed, 04
 Nov 2026 15:03:58 -0800 (PST)
Date: Wed, 4 Nov 2026 15:03:58 -0800
In-Reply-To: <20261103130131.4069212-4-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261014200152.1365147-1-sashal@kernel.org> <20261103130131.4069212-4-sashal@kernel.org>
Message-ID: <auu53k3ODfuMD_nz@google.com>
Subject: Re: [PATCH] KVM: selftests: Provide empty installation rules on
 unsupported ARCHs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Sasha Levin wrote:
> Ping, this still applies on 7.4-rc1. On architectures the KVM
> selftests don't support, like 32-bit arm in KernelCI, installing the
> selftests still stops at the kvm suite with "No rule to make target
> 'install'".

This is on my to-grab list, I'll make sure it gets into 7.4.
