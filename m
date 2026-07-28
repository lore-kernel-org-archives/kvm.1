Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DA42048D;
	Tue, 28 Jul 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233468; cv=none; b=Q0TCVcP2llRqYLwow7y1xdyVlQ+zq1QhX56G7RC3UCu1RSkGOtqh9XoZlXZD0g+JZCOpI+hT3XOEWD0uBCtubmqEU77+FxGhP613q7OOJzSuuTuWK78M9tEGRnyIKX2wyVtNrBfIAH43is1V9r1ATI1L/rnvUTJlrgyJTvCW6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233468; c=relaxed/simple;
	bh=RQImHR6qhT155woOGURk6FhVGY0I5SCU/vt0LoIP6/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLy9XW4ePlTzBh0HBdJXjnoBZSjOiUoVkr4QwM10o4l7UvsDAygKNtDC3zFnecyBBU4g1Q83Xi5EeSoqeTZgJPJsx4wvz4xrQfbThWwuX9uldAs6EvYBDQn5KGX9kH07oI/6NoIaME5Ny3nP/xwuIMZ+6MDsKscIyiJK6+Pj6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hn+zyD2F; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hn+zyD2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=RQImHR6qhT155woOGURk6FhVGY0I5SCU/vt0LoIP6/I=;
	b=hn+zyD2FVJrxucXbV7P5h5sDCR/9G1rm5BjSFW99rfZh6ZusULAD0YJAGUq4hb
	FGnq1FVzhX1nznc2JwphxnH+jfMeT/4/IcuOBhff7dCPUXm5ZqHTicxAPvecMS7G
	04PM9bICvm7xZVSK8H1Rf4U37PJ+us+uWPdSAe6FL6opU=
Received: from [10.42.12.146] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXQPYTgGhqHSDdKg--.200S2;
	Tue, 28 Jul 2026 18:10:29 +0800 (CST)
Message-ID: <92289f9a-67be-4839-8fe4-c6935871a349@163.com>
Date: Tue, 28 Jul 2026 18:10:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: LoongArch: selftests: Add in-kernel MMIO read
 fast path test
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
Cc: zhaotianrui@loongson.cn, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, zengchi@kylinos.cn,
 cui.tao@linux.dev
References: <20260723111605.1630027-1-zeng_chi911@163.com>
 <146b5e27-2ab0-da17-7b98-09235ef4f9c4@loongson.cn>
 <CAAhV-H7pLEUeKWGmCZqDdF+2vr=2aexOFVCMa_UxTrDpUY+gvA@mail.gmail.com>
Content-Language: en-US
From: Zeng Chi <zeng_chi911@163.com>
In-Reply-To: <CAAhV-H7pLEUeKWGmCZqDdF+2vr=2aexOFVCMa_UxTrDpUY+gvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXQPYTgGhqHSDdKg--.200S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO8nYDUUUU
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC6BXZlWpogBVvQgAA3L

On Sat, Jul 25, 2026 at 5:41 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> I think the fist patch is just enough. :)
Agreed. Please just take patch 1 and drop this one -- I will not
resend the series.

Bibo is right that the test only asserts that the PC advances by one
instruction, which is an implementation detail rather than observable
guest behaviour. If a PCH-PIC selftest is still wanted, I will send it
separately as one that injects an irq and verifies the guest actually
takes it.

Bibo, Tao, thanks for the reviews.

Zeng Chi

