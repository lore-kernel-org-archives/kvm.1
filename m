Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED263DAAA8
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885354; cv=none; b=XOsrEP/YoD08NP8jVvTtQjNxOGvG7gkkwgagUgrps8K6zNMDk9v9hLMUnvGwVOdy+tk+8AGnG2xxBjGEy7zeR5lmVjifReo+IFOSj/ljIdG9IAWY/P7Lgalz7QUK/oY9w9VwkiGBMJIWx4+tDM8I7E6l8AHdrzEiVUP+PkpInSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885354; c=relaxed/simple;
	bh=CQxbt8HUW9NzD6kY4dP+QdWUZhtRuWP0yx/1re3yKbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s4O1q30iXUI4qEqYBjlQUPUBlp8KKCTAvC89Som1G7QIKfm+MeEiQlqYRuX3sMMlI9nOe4TmqEmW5z1rRmvlEEiliPjyRegy9CSWW+RIbqsh3yaQTlZ6ubmd1m7cXovf4cBMYxALSV1UfOh9D+9XZv3ie7jQ/wuS1cvdA/mvAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIIG5LpR; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIIG5LpR"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so261470b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785885349; x=1786490149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lz3QUw22bh8QYe/ZiAsreDFp91isZAPnzZuU7CX+ujA=;
        b=JIIG5LpRyZ9YSrGomghxnXaaw9n5pFKARoczMsPVr2lBqhJntkncP0TIeobp8PVg+V
         pBOsecuTT0XITt1zu8vjNN1ip6inffWZzyUAc+XWaLfA6xXGm3bq/O6CsyQbMP9wKfE5
         xy3KUxvnv3dRWSWiiXqIW6Ox5zv/UADVE1wUTKoW2SCYebdZcQo7LnR452xudYG7DNgL
         TSPKcMzBGg56wYkhlZ+dfL0Tu2YyvGOfxnpMnM0qzQ+FiwRVuZVH7ZWDTB1qGpByorKb
         Qm3UTPgRC1x2tlSn4mZhIji+pjVL6BFEQ28q1nUPQXA+xSvpF9t2hzw0vl1n4wzqoBpC
         QfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785885349; x=1786490149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lz3QUw22bh8QYe/ZiAsreDFp91isZAPnzZuU7CX+ujA=;
        b=Z54BygZ178YbKM8H7QZNXFg9j2Adg6jB5GWrQ4pwN552x5u6EMFGNM/GONPXd0Czp/
         ijeVGlIlhZ0HyQ3dSMYBtQJwLpfTH8nPzLSHRBn2FvDKdBUeT6Yat1MlTIBA04yFKZUI
         xb98gdxAsqhDYgZ6572L2ptCRiufRISCI49QRNMjjht83K34vhTXx3WMOnnK4rq9i+cj
         Mx/bwnDyZa/Iz0jCKFumgJed0XnxP7zfEbvzcAusSeTVRV2NykK9f5DPx1NbOqoxmPcY
         GBR8jsXqy/R0hJnT7OVbd4Di3IbtcQKHVw+ocT9DvMrCLxdsbQO+p9FGPKWdNkGBLMGF
         5ljQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNuxAHrM04fRFrcjWCZVZ3re59AnzczDzykpvFA964Jx7pf8MFLqQww07+RriJ9dNz6ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwihHvbJvfy6SMOIBsJ4sRDr07M48P/saLge5s8pA/Li+28Nq5u
	bb/WaQfKDHJa6nMxsANptntp1ssD8J1Uq0PR1hlydQQuUmSdIq188BZxEArBxjPSbipEkn1qAjv
	HaxDrlA==
X-Received: from pfbbq18.prod.google.com ([2002:a05:6a00:e12:b0:848:5740:db83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9517:b0:84e:e809:dd49
 with SMTP id d2e1a72fcca58-84f2e12d02bmr2017520b3a.36.1785885348892; Tue, 04
 Aug 2026 16:15:48 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:15:48 -0700
In-Reply-To: <CAEvNRgEOE5oeFVRYYucsCGJaFAQYS1oNRXAwGKzRAyqmoHT9OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
 <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
 <60552bee-3326-4917-b00f-5fb7ba3b8adb@kernel.org> <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
 <anCtzQrUkFSSq8De@google.com> <99037993-ee13-4160-8c87-b6642faea554@kernel.org>
 <CAEvNRgHYhKACDfx9ZZy4a-TTS4yWzEJt=Jc92=eXxS15LPnTYg@mail.gmail.com>
 <anJbMf5GBe0Pxh_x@google.com> <de780cc3-8c43-46f8-b8e6-3ddfe93d753d@arm.com> <CAEvNRgEOE5oeFVRYYucsCGJaFAQYS1oNRXAwGKzRAyqmoHT9OQ@mail.gmail.com>
Message-ID: <anJypPblO8ww0IHY@google.com>
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "hughd@google.com" <hughd@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, Ackerley Tng wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> Sean, for the two attachments you left, did you intend 0001 to be the
> first patch in the conversions series, or separately handled? 

Please include it in this series.  FWIW, it doesn't have to be the very first
patch, though that probably does make the most sense.

> and 0002 will replace these 2 patches (in-place, in terms of order), right?

Yep, thanks!
