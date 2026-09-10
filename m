Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB03DC4D9
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038216; cv=none; b=j2xx3EyHpnRID+Eo+8wH7ivnhRG0XdSS+sf12ErLk1ei9TFUbiFc6ANq4owOoyeM4JzEGzW8ka6g0wK5kt4/Ogbdgpv3heyXNHmx6iCq3pa0gaqG8Bt4IzRsG8u8GovhO/bRdsyGfIfd9L8ktR1iwHG1pO7LgTI7MMzJMoIgHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038216; c=relaxed/simple;
	bh=3gHoeS5DETEBmd8V63FOswxYH+BlwM2UupwRK7ysm3U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kiprHKfumu8OXNA0oyd5qms76eNGSgGaIsiHgfFxSc8ziFfZCDYrSd7NYw30jb6UaOPPpgF0s0vkOdn3eadSieUZdu01AoAyCy9Tg8rqHMsTEc3rP7MU15YL9C7VhW6GgRg6OiF172lXVY63v2aHw6d9nKFzRi/97ptbx7VxJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em6YZZv/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em6YZZv/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1438690a91.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789038214; x=1789643014; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hx87S2Y2VYrsz+ltlElpgYkkRP/rEKOc33NOUB4sPbE=;
        b=em6YZZv/DjbS4FIaDqISPIklDKqqy0CZ/CC5RUSa5uc2EZr69AqlyogehooMJbd0m9
         imlS4GUaTcg5d2+Acki9v5ZBoII92SWaKTDucBQ1UFDo1wksJssdIGxP69mEosFvTNs6
         4L0/RYunWb5Dm/GXeFo/G2FfitXHwbe+fxKBhkP28nSI/GQTpVWdd82ufZZq+uBcfO6V
         FWxFvxl551zyAl5sMCRPW5+Zm++kCmsu6LpEK+VtNyK2c50/A0/4kMZACscHCiV1fZpK
         xfGnsKvK5/fZ/eRP8Y9P2I/5QQlsR8BnodUWP3FT+dE6Wvd6L7B9JVwSBPZRsZqDSt56
         tMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038214; x=1789643014;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hx87S2Y2VYrsz+ltlElpgYkkRP/rEKOc33NOUB4sPbE=;
        b=HT+LPWFSxdivQ2P3rnvOPXXYDK3e0xeg4ck6qF5Q2qr3V3nDIpqIN4rGPz3O5QVhVC
         F7YaJha/gUx7tl97f1OgZVUXzBtcK2PL7zXBy3UwkmdwCpc9939q3fY+Gla6q7zGcIFJ
         6CTFRKNEf+MdR7TujhhH8NbX/Mu9MmjoMwLo3zGSUdgBSK4tk8jKdU6vyj7zcIZZLmJ2
         SeeqxHdGVsGbwTCd7DmZbW6rkJgk4z3At6Bhj3Bf+burWQY6iKuQ4fUi76J7u+2uojCU
         YLf8abksCPBOAPVJ1CTmQgazXCHJ4/kFO7shzsQqfyONnv0stSAijfbl+e3Q40sopjK/
         DeVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrND9AuSQqZSlW0Od9bhaLspwXnIzMPeW4/5o13b1ldTzTMU8hQPb/1SRGkoPmyNm6n9c=@vger.kernel.org
X-Gm-Message-State: AFuF++llRpRhs8F4rwNqMDam1pwDEVbLQYk+AyOk+jwBHITY38vO2bTy
	uKXOCBPukr+geDk0QKTt7i4RJ/r8l6ubQnM5zASIZ8bnaBBvPapMeFU0
X-Gm-Gg: AYBFou3wZN2FH7/3c+qD+RyaRlrynwQoP8x03eboJ5ieDPH/PCamQEi2dOggdvxK6MX
	fLoO7iAOW/LDiSoAVnXmIbelMqMyKkdQsZZeNod02o6OBNtZB6VNA3yNwBk2YrEKN3sZpqA7ahT
	6KTlx6whDJJNQTg4vTucUSYoDZt4RII4300eEZwrIAoEo+gwHS+XPxOduZWEN1DE1AXN60J4pwO
	B5j+oANB5Ryqx9bd0qCTA9tEDy8oJ4Ze96RJkW7rxZOEmse/KKeI/DkOx+DMuw+FQhUJCXtJLDC
	9fDrO3kTOB99HXod2Ci1GsBbu9oxhqEbPmpvhAVCQGLKr5aBla8em6C/l2Ro3kOBZeukS+wiSri
	uUJOSAeV4356qPDEXnlY7v1+4Y3IRCLfYaKa9y42ZxitMk+n1yOnYAqlyN0tUNaAa7gf69wNZT5
	rrwCojxuCsiHB9uVGnEB3CpweV7P3gwwEyMmm2AZbmshsN4f+C3sh7KI6v/QsZMWZhoT/x/7BKc
	Cm9g4yzkIrhg1b1t9qFSIYWc5dNziwi3sWcSacXN+q6XV8r4L+utZI=
X-Received: by 2002:a17:90b:3e46:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39d70a5931bmr11901184a91.10.1789038213696;
        Thu, 10 Sep 2026 04:03:33 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm50133517eec.10.2026.09.10.04.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:03:33 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 08/20] KVM: selftests: Use the innermost page allocator API in the memslot perf test
In-Reply-To: <20260902164123.2546762-9-seanjc@google.com>
Date: Thu, 10 Sep 2026 16:30:42 +0530
Message-ID: <a4pp1icl.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Use the quad-underscores physical page allocator API in the memslot perf
> test in anticipation of converting the outer versions to take the memory
> region type instead of the raw memslot.  Stating the obvious, the memslot
> perf test creates and allocates from multiple memslots, and so can't use
> MEM_REGION_TEST_DATA to communicate which region/slot to allocate from.
>
> No functional change intended.
>

yup. Indeed the later APIs will drop the memslot argument from the
main/outer page allocator APIs, so we need to use the
____vm_phy_pages_alloc() variant here. The change looks good to me.

Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
