Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4444DB85
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624591; cv=none; b=ebF7f9DDQKXxyA7ozKd745dOsTPVl5XhtXzc3HmfAf9hUKPWZrvJLT9rsqEqZWUJFwXEn4U5nYzXYz2+PqIY9OmEEqQmDx/kzwJrkxdkfzisFKfFN+cA58shgnBLoiXReMsW4yR9FMZzmJA0I14d2B1F1WkTbe74Oq8TREte6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624591; c=relaxed/simple;
	bh=z0Yi+ccp1237LA8Mtk3EaNcrP3jhyczTa9ge8x2+pi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlHsEFmYLDmzjCE24X6NhGic0AKOU0ZEFE3aPTj/TiQBmsEOfFKPLhjqup18fItjUzxYLoJHaijDbX+rwAwZNd6YWy/csbk0cgaUS/pUE/0rtWDYzspQXXqDahBHLTrE9cizYFFneLPggjfTV0ockLpim4ndaz73WPAU0FRYSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/3+HO9C; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/3+HO9C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781624578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0Yi+ccp1237LA8Mtk3EaNcrP3jhyczTa9ge8x2+pi4=;
	b=p/3+HO9CuS+TZrK8V5uNvwBhzi8hcizba1dcyw9SgkkGiHG57B7LJ0YnhLDLYJKX9PfEhH
	1VMxkstwQk++3e8ERVIU/BL80NHY82HB2T0ivY9FroTtSFyiYr5NXyx/5MOYwvM5/Kgx4e
	AzNtuM4JeimJ7YTy9Lnfo7P1ylYnxHA=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	zhaotianrui@loongson.cn
Subject: Re: [PATCH v4 3/3] KVM: selftests: loongarch: Add PV TLB flush performance test
Date: Tue, 16 Jun 2026 23:42:31 +0800
Message-ID: <20260616154231.10982-1-cui.tao@linux.dev>
In-Reply-To: <4efcc81b-bf7e-4d78-ba82-9f4590673486@loongson.cn>
References: <4efcc81b-bf7e-4d78-ba82-9f4590673486@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Thanks, and I share the stability concern. I don't want to land something
that adds risk for a feature that isn't clearly earning its place yet.

> Do you have real workload to show the benefits of the PV TLB flush,
> and which TLB APIs should be hooked.

Completely fair, and to be upfront I don't have a large-scale real-world
workload to point to yet. So my plan is to build a set of local test
scripts that simulate as many usage scenarios as possible: mmap/fork-heavy
paths, kernel-range flushes, and an overcommitted setup where vCPU
preemption is frequent. I'll report the IPI and TLB-flush overhead with
and without the feature, broken down per flush API. The coverage is
synthetic rather than a single flagship workload, but hopefully it can at
least give us a rough, preliminary sense of whether the feature is worth
pursuing.

Thanks,
Tao
