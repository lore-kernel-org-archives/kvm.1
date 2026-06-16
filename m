Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705A40B6E0;
	Tue, 16 Jun 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600525; cv=none; b=iV6pBRhKC3W3PTe4EQW0Q+vxAKZ8ABCb5YXMZh22Jz2gDBjBZ4xfD79FRXw7EyevAFJAZDMvE0OJq3x7f8+dkNZWVt7WHyq7uFHr9CahNBqZXLp4qiNUin6r2L1nlCo1P7X6kuEdQuBVEnLwL/7/ce81y03ivrsUQBWjxPCnYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600525; c=relaxed/simple;
	bh=49w5pQXimTq2+rcz8HAdsxh2TDzJGYdv1MnREY0ukuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4k9BVNvfkiG9LEKPzJOIBfE94XWFQe/GrEa68Ou/1Eug1zwtxD3DpKKEqYm0gZ15lZCEpr1uWkZYjFDZBPbZ8Q5Bdy1jGvAa4Qr6UtNQcDnbJw5dn4iTgMMg+47Imb92o706CrWx6VvpIzAz0BmKXKnYcBcog23orCC+1mDiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LWXn3Xit; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LWXn3Xit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=E7
	8rCGEndI8LmHgvYI64KGxmrptBpeFFszYQlWaMOcM=; b=LWXn3XitqQLYox9FZF
	uka70RynGoyaJ8LCdxttoKRYgReynewLPDlmL795qJlh9cH90XkVYfsJ1ojLSiiZ
	NeRcxTrsXkMiqZAGYkBtEjPtW1hnctKvgHxDp5UziFWRTFgX0HTH0svahYaXK3Je
	Pvi5Dc/mOxW3rwPa7R0MOvUVI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHlAP0EDFqXkm_Cg--.9273S2;
	Tue, 16 Jun 2026 17:01:41 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: r4o5m6e8o@163.com
Cc: eperezma@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	wangyufeng@kylinos.cn
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Tue, 16 Jun 2026 17:01:40 +0800
Message-Id: <20260616090140.61347-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526080336.61296-1-r4o5m6e8o@163.com>
References: <20260526080336.61296-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHlAP0EDFqXkm_Cg--.9273S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMlkIDUUUU
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzhUonWoxEPV1KAAA3N

Gentle ping. Any comments on this patch?

                                  Thanks
                             Yufeng Wang

