Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37242868B5
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617604; cv=none; b=CShiz+mWQKBKheH7jd9/QMZ2wlxn7bN0aiAadpeDqHpbudyy9aOfVsnLDIM+PCHSsdmnPghfXPG5470bz9dDUJ4lNjDi2acsdWuNRV+Wq7lmGIlPrhrukqEAvG6Lm5FKdVKZsrp6mPV+wh8lcXY3PDDM1HWxThQLnx9x8Z26tb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617604; c=relaxed/simple;
	bh=x6A/v0v0NNN7dzQ8Ajqsz3CqsjJ+V8Ilr1nT2Fz9k98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fv3HYyV3v6yJv3qigs3itKAi42LaoFNj+7I10Z+Mv+jIjztVV1xdDUcb6IG1ZxiNSKdm66vMb/cNJ264b/w+3dPbwc2QXkMz3ItFKtZn0lHla5w5Pw7hatpseFS7ob3UCF9qwbB7hCTx1faP0mE7mkSA5q+xoyxoKGsgNJkl2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nzkZvR3O; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nzkZvR3O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781617601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6A/v0v0NNN7dzQ8Ajqsz3CqsjJ+V8Ilr1nT2Fz9k98=;
	b=nzkZvR3O4+IRB+PkBSME1O0LnnOjS7lBlMq/tc8DtyhSETsUZ1MhlZSrJ29h+FvEIqZh/o
	y35LHMpQVC8omHysufZqAOcONxGgGXPeoQUBfs0EhwQtHtCs8E0LHo7KJC3SN+UOraI1Kt
	zYX0KpxcRIx86qWo/MpwV4CWxJPMth0=
From: Tao Cui <cui.tao@linux.dev>
To: gaosong@loongson.cn
Cc: cohuck@redhat.com,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	kvm@vger.kernel.org,
	maobibo@loongson.cn,
	mst@redhat.com,
	pbonzini@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] target/loongarch: PV TLB flush advertisement
Date: Tue, 16 Jun 2026 21:46:21 +0800
Message-ID: <20260616134621.114322-1-cui.tao@linux.dev>
In-Reply-To: <636afc5b-968a-3027-8683-21df1c14838a@loongson.cn>
References: <636afc5b-968a-3027-8683-21df1c14838a@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Song,

Thanks for the suggestion.

Bibo has also raised a few comments on the KVM side that require some
adjustments to the paired kernel series. I'll rework the series
accordingly and regenerate the linux-headers via
scripts/update-linux-headers.sh in the next version, along with those
changes.

Thanks,
--
Tao

> Hi, you should use scripts/update-linux-headers.sh to update the
> linux-headers.
>

