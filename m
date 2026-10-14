Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1639A060;
	Wed, 14 Oct 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968526; cv=none; b=sMgoOLnnTJqCo9jljA4WhY29BqHRjT35tLevCCzb1UvS1/N6sHqw9wPK8K+5xmG6XxKXN68WPu9HgLElPW2IzSUOYuusByygJ8C7SmzaLuzh5qPjR5fHjX8wCNwLeNP8BHoKDcVhHA88VTALy0RDPHejG/J+MeveBo7w7qjRQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968526; c=relaxed/simple;
	bh=eSj2Ehj3rTJ7XqMU1hdnsqqWovY4bdv9LbzLlMxB5Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2eldCldnbaHPuwoQoLqI214KfUcnZWhjqLrIglpVsoo4zJALjAJp/cF8McI+no1vtnQ5sI/pIbzmtZvBMP5jJUePc/QBxwlG8WcGVKlAWOGUGe+Un4moXylNxchIcoGPblCL7UsLIBQQekGavXBNUr8ELGXq4n5KvuHiheBjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hg2LdJYy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hg2LdJYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=eSj2Ehj3rTJ7XqMU1hdnsqqWovY4bdv9LbzLlMxB5Ss=;
	b=Hg2LdJYyqwbd6mR/mqBidrUAZruGbSJSyyLgJXS1TOjdWDkfUeQ3ZNfYOA/kvm
	mlCyU5bvP8p4GhTGimxXNRz6gKlZjhTqi/RZPgFADPYTTGMkYeqyviAb4E8GRx2f
	pT+PmXiKFF7pB/KvHwBCiuU8mJK6uUX19EQvJRZ9kXO7Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXtj_ERM9qyf14Eg--.14109S2;
	Wed, 14 Oct 2026 17:00:53 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	nutty.liu@hotmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	hppiscas@163.com
Subject: Re: [PATCH v2 0/2] RISC-V: KVM: Validate AIA MMIO ranges against GPA width
Date: Wed, 14 Oct 2026 17:00:50 +0800
Message-ID: <caplitmus-rv.reply.20261014.aia-status.3387a76a787b44fca8fd288ba84ec964@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1789872556.git.hppiscas@163.com>
References: <cover.1789872556.git.hppiscas@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXtj_ERM9qyf14Eg--.14109S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUesqXDUUUU
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7gXQmWrPRMUpaAAA3H

Hi Anup,

A brief follow-up on this v2 series. Patch 1 preserves the required
address checks and limits initialization revalidation to APLIC, as
discussed. Patch 2 keeps the reviewed GPA-width freeze unchanged.

Is anything else needed before the series can be picked up?

Thanks,
Pengpeng

