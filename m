Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03C2D29C8;
	Mon, 25 May 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720120; cv=none; b=p6dXeKPS/GqgMDT6sV4iHtcjDrTAbdlLD4825q3lucY15jvE5XO6RIirqrLye09nKldk4bFPKL6cuXS1p/DE+QdDBS9Uk9zTbTDN//auPwNbVlgk6rVJxBRRaSGAL+9F3Q9ZN/WjJEyGvahF0hjiw6Lcdcn1BdSi8eU1xjQwylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720120; c=relaxed/simple;
	bh=g1yljOn+I0uX5WJ7Da+AVF7I3bwZLJKvL/He1hKzbQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvzSsPCyIsqc7UiDqhIaChwsNyFx2jxzH9qDcUrgHTAsCPR7XLsuWSoJvfj5gthV9PHZl4Gyztbz2hCKUaHnGsLDueF5OcdPR1aoiJWKV9ayysTiZY9OJPdVi3sUZ7M1ZGnPkGBn2IgEmp2PDhUp+0qKahonI/NKRujkQ7HuUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Qe0PHr11; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4IUI8S5; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Qe0PHr11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4IUI8S5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 7CC34130038D;
	Mon, 25 May 2026 10:41:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 25 May 2026 10:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779720116; x=1779727316; bh=PnS5+hXg8zM/uBnkqtNnKx0lfH+fdAFq
	qZps+s+LYiU=; b=Qe0PHr11cnnci+E7a8ArJ949nEn6XQaRRTNfJ+pbk+qmsXbq
	OkXqr7WFi4J5MkKlNv/jH1A8IIPyCZ2bR85a0tLbhaFwWburtTzjjwHP7Kc0yObN
	Nl6P5VB87zOaDDMnNjKw80jJ3fTP+KOGVLlgBIXC/mGZh5VSrvWlKJX3iRj1nUXp
	1VWy4P6FC83ZjlBLLlcoImMGgxZP9iQLIP37OrnhuSbrgwtDS1BJ+7Zax4CEInyU
	gSXm8Ui4w71NVEoaWIrzV2i+yqQh9SuRyYsZFL+4j6HQPu8qOJQZ1xQY52lgjsbS
	MD9uWjxfRPYWGmZqDd5rjCCngbpvFwBfveSiGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779720116; x=
	1779727316; bh=PnS5+hXg8zM/uBnkqtNnKx0lfH+fdAFqqZps+s+LYiU=; b=E
	4IUI8S5Nh3vDp4XXiwdQRaMdqy51ZUdd2568cGLJ5WsAf48WDXBOHyUWRhWWsuH9
	2ohgZomUnOBHrb6hF2inIBHXySB5I9PyVNSzDHHzTmae5dDEYiq3UG1XcZ0PyuQA
	MpQT2alGPx4O9PKfhLcW33Xovn/TGUPwrOVf3sFu92RbsyvfqDgDLfSKIPgHxqmw
	T4PRDeG70r4Jun5zZH2IEoI8X/JzaCrhU/O/zpDVpXVGWXYINciNL7yGobhEtPE6
	EE7mpW4GKH6zSWOfwESsQTnd58W5aAA9rwAXyx13xpNLmNA92jG9rkHLjEwRHwID
	Qp/9pyPG7TIIS0hm0u5hA==
X-ME-Sender: <xms:s18UalRHDNFeOe3OTBQrFotPD66VN2u2Ly4GPFB6QarTbGtKrgXF2A>
    <xme:s18UamDgnrsESAku88fIMRB5G-1vL4ISJPgekl2VsLyCx4yy_gyKuab9cacA3ftjD
    0nVp8lMdxSY-9FwglNyKMoiIzrUgK9lMFaJWnNOr4RdH3b-FlJc0g>
X-ME-Received: <xmr:s18UavhHw47OsCkjPL2rGtIolMQGuALs1a-RxsVw0BEu25uYsPtoygDaBOom8A>
X-ME-Proxy-Cause: dmFkZTGHZHLMjCHc643dxRklLh2oL/Fj1m4IuOELcM7KtVw32eoEW7vO/KG/cKBnN9WuTW
    xcg2IQePNYL331E/+iFrg9l3Q/0DfWc/pfzb7vWOi1Q3A9a5dIAx/Ip8sizV43jID8qi2T
    lPu7yzYYlC4jDwy9+0KEeh9FZYrc3IDuLVpMqBcYmpa2tVNF4MKCjt0kSOcetEMay+qG0j
    wZaWuQuIE2LusEhaCt/KcTuXfzwWNSSA/a6+c4ZC+utd7D9qUqXsnLmKd9bKV8qtvZC2fr
    pc8OG7aEFZFvhoMbEdIROsQzF6nr7BIT6NX92DQHbwsijQVdrSxa73C0r4i4pngBeREvjN
    hL3/kqYaofWdis6FczySG/sGGaRFcfuWQN4L5qMxnm2Rr+zzf1FxksyzGoiJv0k2FZ/K8/
    zQBu704Uw0qC1WUVP+hCihCOAHiH6XNmcc/jpi1zpZFBnIg72Dyz47nrLXF3IwkjFIzAto
    YjL4fW9iAb2sW+Vn4xEM8f0jhP7AufVvaz81ReUOMH23fd86Y6b3vy0foQkS+jXxDI7Xny
    xnj8rwQQ/qESJ5ItTQryqChWVlS6qj45d6PwWMc8Nqfhxik/XtigjZ0Xh8wk2D2pyhkRHq
    iaa7VTA7vbSK+AN0OtxxIDzz0O6aYvtMB9kSNLQR8XH4TbtRD8yizHSZz3eA
X-ME-Proxy: <xmx:s18UaptUyk2cm1cS1S8PkaMgt-0ey829YeBygKC3HG5-gC2y9DobOg>
    <xmx:s18UanIvnL4SOXBk1EY3C36P7GanH2j4vG4-ybdXMhlgG0ABKCiTGA>
    <xmx:s18UakqCqU_oct1qD2WFqCZZwTzcuIALl3fEMd3RtFvxNl0BWgg_PQ>
    <xmx:s18Uaj8iJrHBe0GLgbxMB_gpLlKD9k24wOQ2Wgc40b1dzLHj4cAZ7A>
    <xmx:tF8UakHpVxht5wWYv810BB8EPx5PKQBvAYDCYdMW3VylUs3AjsxKlXZW>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 10:41:55 -0400 (EDT)
Date: Mon, 25 May 2026 15:41:54 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 01/14] mm: decouple protnone helpers from
 CONFIG_NUMA_BALANCING
Message-ID: <ahRfP026tvXw8gI6@thinkstation>
References: <20260525113737.1942478-2-kas@kernel.org>
 <20260525120640.328441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525120640.328441F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:06:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditional selection of ARCH_HAS_PTE_PROTNONE on LoongArch
> causes boot-time warnings/panics in debug_vm_pgtable on 32-bit
> configurations.

Confirmed. Will fix in v5 with:

      -       select ARCH_HAS_PTE_PROTNONE
      +       select ARCH_HAS_PTE_PROTNONE if 64BIT

matching the x86 ("if X86_64") and riscv ("if MMU") patterns.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=1

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
