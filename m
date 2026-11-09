Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254506;
	b=WElUTCbBatOywBEAZu0ub0gGnKAK5wled++w8dUSJipIB5YHp5Dua9INeJbpzBJkw6zR
	 X2Fhz5yXH65XldK17rN+tZylfssQgjYr+8kE0gap26xBu4BJ5caqB1B6u2q3RrQQeSnr4
	 P+B7B16n4FZf4HJJ0vFne7vDhXquYBGrv4iWHUnXdzaJR0rxmEjTR4h5tCS+C27CoN1DH
	 L/ep0mQq5N2w2brHPaio79BN7QjOckkz8kxcw49HPQQXGBTG0Zz7wXKx2ZbO6to73Muie
	 hXG11Qlm9JH+/RcA74rFlAIrQ+UiSXyR0uml1NIa5jPMnwpBQK+F1eXUbFBFFSQy6yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=J4VE9jPLkx8Wgxv9dqM+38TTLHjiOxYTXAGaI9TvUkM=;
	b=5Q3JEkosRJdLE0GUYRW9YEO7H5ikKZYU+sbAjpBi4urUhsvEtoeKbiiXggiXRBeovNjJ
	 zR87ybfTbpNur+xfNfQQyb8bVqobb/MgP9eBga4VQiTSNMfKpC9TCwicmZiQe7SnxUKj5
	 y4YMe6rgGMBcf45j2VKr5qrgNLkReJF5yZYiR3aZ7ia6zh8tIomil38alM/sNyJs9sb7b
	 AhW18J0J9BaRQddKceV7C0MHdQxkL0p9wSqxDL0oIPzCFrARV8NUqmUIDwBAKjCJw7x2Q
	 IdHzzCCNws50CJ8YB/iK8aX16SyXHA+WfR447l365OG01/ztJIfJ0Du/klv+7Opr59Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VVPYRW4J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B39606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VVPYRW4J
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso13196816d6.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254505; cv=none;
        d=google.com; s=arc-20260327;
        b=GrfSk3a3uvHSueBhhxzqcf+TNv59//aYu2xDhB8GSMAdhhWRPvolYQ37zFc2se6gJD
         t6he++XyTPAbMkVuzYy1ddxKDitoANTsuWMr4Ph/KiH1l4Nl9PqSSM9YjQ7WmxbcPZU2
         LfL6N3K++obbfkl8o8HQOrbQ8h5Ru535bBjPrOrm6vMZmauzgdXFt3yrjBPgt44JFtdg
         Ee4lJnEGjP1wr/6qGYYa4mposWyByfaqciWlmJlnkGAdmYhai/0lPziXcv3WvN9PiKOK
         UGkxHwFr6IPM05o2EeqeBBozVGOtIUAHsy0wEpfOJbvqNQvVuwqsY0hd17DLagvjq7CK
         TrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=J4VE9jPLkx8Wgxv9dqM+38TTLHjiOxYTXAGaI9TvUkM=;
        fh=HoZ0X4CaKhJ/7yeUikBYhw8k1BQ7SJw6RlUBjwDB0eE=;
        b=CZtg3/cNm1AcQc8/JPtEFrT83tmrmOzShqA7xJRsRtrGHPIplEIG7X4/PTqzE1zdBB
         pPIHp8CCmQNlN0Qq9JyEVlopjaYgJW9/bgTNsFQLkoy6U9cwhbiKGKiEjmwatLIWLHVn
         2ZH1gr98o8VjsIZjy/mZV6PteLTUv2cJkcHiBTj7qyhE//mNOmBqNrnegI03FQfyZElr
         FW9p5HJdQU5IQCByrXhLsiAje1iDrPcXYTVmHXuKawRF7vMW35K7KKTrrQ1gcbIxSVT5
         m4GUuniCnzhGOXJsYQu41OvMYQahOQkzIzkFLO/acRiGhS2WwDm/DOIEK8GYmthhhP8O
         T7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794254505; x=1794859305; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4VE9jPLkx8Wgxv9dqM+38TTLHjiOxYTXAGaI9TvUkM=;
        b=VVPYRW4JPvKdjZtMe60xViJTU6BBoc2rCxcc+xXkxgWvR2IBMqJdLO9vMfmCodQgi2
         LGdZQhiKlhxEoMvzgVUZ4nhj7VowzBl72y9cmNHm+o2uZmzMVEg0HyCOT5yj2bbO55hh
         ZOr4VijaX1waBVZ1yPYmALNxxoWgCRVkceOUN4uxRgNQlYRiPD4ziOKRCYrqLawMAQNH
         UQiD8UlIRpS2xubC9lWbVmcz23NYznk35FfNHKS+NUm39MjNGY8AkxFReM/KMJrKHrHA
         6TKwrtxjuoEHCAjmZuEt8vQBDdkcr6zAOf1Edvi3KSYbgxUXL16UaEl9Y2kJoG2MHM3E
         BeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254505; x=1794859305;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4VE9jPLkx8Wgxv9dqM+38TTLHjiOxYTXAGaI9TvUkM=;
        b=OPUwOW89ukWjZkRnOKPmIwBzdhD5aQMHMhJ3tdO30abgNrXi3Gw9YpYI8reo+G24mO
         8qa8I0wcDjqikl6FhVsZoxsAiUk3Gy0SvKw1Cm9QQsFUxNAkXMi1Gf3g+tWjvrssGvyM
         YDHmi4uj3YzaYPRDTFt/V8+ahYLvTmNKfXxJUq0obW+Lqiup/332UxVvgRVq+BgixaZo
         UOlxGHNhaJpV2MwsQv7JjDUX8qHnZyUyQfqefQwFgcjzLxJQ8YPlaHwA2L2CAhH9mN9/
         G8Erp1kNFaE8kCojGDtfkzKQ1v70a6pOdxXeJJ8fjHlLKxiFJ8JiFRVfYe2WeGXalhd3
         0nTQ==
X-Forwarded-Encrypted: i=1; AL+hErFrkDqpBwjpnok9Rgw8kJpOYKSn/g8GLWmh1rK8Jl7841o+fGrOcDfTin7KdjbneOMt5ZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JSjQl3Xe7qcPhS65IzYLTaqsk4+iX4LT+QHigyItABDB6Hn1k
	6I7X7IDBgMvC8WBI+B4LDnwWDLPC/ZehqKB+1YztEyqinzI8R/jBl0IQRiB2dmIEsV5es8m0PoM
	diz/OIsOV9MxxxSTI4DZfsKonsMNFV7Kt3xymYWsE
X-Gm-Gg: AYBFou27JgcTxdkiBnJ3eIBJQ8L5ACmdd4ulI/Wi0aC8hT3Ri8m3vLF65deWmOfGrwU
	tdmlO9O4RAJg6uEdOTj6xS2QQ7wLLdcDKIYL96zoldcLdOR57XXQR6TKG9uuyPZocsoDCjJ3R39
	zwFz2Mprh59N1YdWCkKK9/IApI16LRvLBsy73SY2aHyjLaKQDJTO4dxbApuOZE1jxUgupmEBbkU
	1Xqg6C9Mg02E9Iknb5wZMsJQXeMYEGhd74ba0pE54tVMy+u+72IZqOgOGftgtt82PmJ9LCrdGfq
	OH03DNrR3WOGJFCBWqmcIwlmdvqUlSad95cXU83kn3A87iEwafcaYA/mPk5gcqXxzUBRPUv1zKn
	zqiyy9LHI8vptb0wgsrna8nk/sOtP8Yo8XHr3BJKRKhrPlLxQRXSQxaDNnDV/0SYa2mlhVrT9fD
	Bk+N79w7Btmdq0yG35S9lxG5A3SkxJ0cCLxkM8ju6haF1B
X-Received: by 2002:a05:6214:1d21:b0:91e:9664:4e2b with SMTP id
 6a1803df08f44-91eef7a3c83mr11947696d6.7.1794254504037; Mon, 09 Nov 2026
 12:01:44 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 12:01:43 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-14-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-14-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 12:01:42 -0800
X-Gm-Features: AclHuK965yyNFO13V7bpMX0YP25CWk-grxkHlMzQ2EkXDGXWn8vJSUwM5EQspQQ
Message-ID: <CAEvNRgG4BGkr5QhNaOQrBLzGp5uy7Bc8Lv0c5a5tp5uUr047nQ@mail.gmail.com>
Subject: Re: [PATCH v16 14/20] KVM: selftests: Set entry point for TDX guest code
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Sagi Shahar <sagis@google.com>
>
> Since the rip register is inaccessible for TDX VMs, we need a different
> way to set the guest entry point for TDX VMs. This is done by writing
> the guest code address to a predefined location in the guest memory and
> loading it into rip as part of the TDX boot code.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
