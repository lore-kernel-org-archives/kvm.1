Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74040F8EA;
	Fri,  5 Jun 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642064; cv=none; b=ircZWZwtUq0cDdPEmaV5+5yjzljJD7XmK/fv6vu5jd2Z+MlSc3dtJV1P3y+WqvG83Ea+h16P+l1WyLxvfAYsZUZiTE3LWibto7jtR+JRU6VvCSV4P+wJ/eDoDXzUDPc8uAsnzP4KhZ8eoWfSBWvUVMR+ze0NOYenaeZNby6qnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642064; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJcP3v0DREElH0nnlXc+tGgmPUPPsTLCInJiAEtIqGu/qIJY/ZKbMiz7NBTY9uu9eyRwLGLJcubfWoAwaJTUXfvBnP60Nidbg3IyqJipXn5umuqbg84gUFUOzrbF8Bfm23KSCj/Ial/2qcVn16J8kUORn5JOwv0kqsSatB7WBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O1syVw0R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1syVw0R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O1syVw0RObUNsUloXhEatKWUIe
	+8iwjfg6FEZjfbqmaleJjUITEnUf87i4rMzY0ykIJQN1Z5X5WxmLKq0/sQgK8UbWrD6KIA9+Jo/aM
	4NBngO9DpCzY8mbr+EQgzQQhdWAGPiz3/ryp2KRUSoYUy+Ngol++HwEOySoIcZ/LyRhs/aWSMbEYG
	wcXpqUl8Jqx/ZSLw96YZ/vY2f/5HwrvN/mFF6n49gnbmeQMlvJJ5Dudp2vS/Q6gS/5KX9o2+zIgwd
	sqKvUXSlr2SK6bDM4GEf/FZAJTimGblho2KAyWQi8w/b22h+FsbF+fbhkJTLkrRdx69Voe1JDxvOU
	ZEmD7VJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVOL6-00000000BOe-2pM2;
	Fri, 05 Jun 2026 06:47:32 +0000
Date: Thu, 4 Jun 2026 23:47:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] libfs: drop redundant SB_I_NOEXEC/SB_I_NODEV in
 init_pseudo() callers
Message-ID: <aiJxBKwK1v2e1wQn@infradead.org>
References: <20260604025315.245910-1-jhubbard@nvidia.com>
 <20260604025315.245910-3-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025315.245910-3-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

