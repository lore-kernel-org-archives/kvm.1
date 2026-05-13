Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160D3168FB;
	Wed, 13 May 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634091; cv=none; b=WNF3etvMuZUeaW27h+7d65Fdd1TNGuRo8h9+kiC3eaAGGiYR93w//l5rzX/JyC2xK9dtbMiUPc1qx5csDHj6GprQgjv0vUCefueVTKIzbVpqJajPlti8bClZItkC7axutaxB09wCnur/34SjBHgPD7i8YWDCdWaKwR8DiTKDO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634091; c=relaxed/simple;
	bh=pEZu/teuWxyBpzRYir8exGFyRrq6ovu7WHGnOCsrTPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBHIs8bJ8++moH4P2ZuSpss9i5eDy/8vzPr00zm2sz3nSz2b3Q9REm2MKl8SbJKd56qwMfrMcz/0Vb64yZ4xDUj/19v0M1JGG/kfIg1v/RbQ+5d+/B55O8e2eZLf85EqKWbpgltnyAcmRgX08CSUqTM8n0aktTwViqaiaA0USRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khDs/Wwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khDs/Wwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4570C2BCB0;
	Wed, 13 May 2026 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634090;
	bh=pEZu/teuWxyBpzRYir8exGFyRrq6ovu7WHGnOCsrTPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khDs/WweQokhaXm59QjnVizjXmM+2v6i7Gz++6bUK/T7qBaVfn+iNQZqxHQGzrBz7
	 +pNw0f37oFO7yXEvYpZoPMKHoWx1/yKux7pS349y3pf7ddzgtICF645LrwMRsji4Lr
	 LXHkfAQAZHMU6EIAFFzMhfknAKOEZTtblvIGaSQVcH2A/I3udBJes6VuREjDI8aQeF
	 sHaVrzIfU8chojh+5tXYW6dOkf4MLuTDEpclw+4PWoWxf1MT4289OiDZXEHAjevdYj
	 oIELp7GiuXsqsZ6Ig8IncmUUV5fZwAS+OMYTRXzjdaLpnaHIvlyZtpS/O8k34FSy3u
	 vlTDBjn5vSojA==
Date: Tue, 12 May 2026 18:01:30 -0700
From: Kees Cook <kees@kernel.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	thomas.weissschuh@linutronix.de, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] selftests: harness: Provide global metadata
 pointer to allow clean teardown from selftest libraries
Message-ID: <202605121800.46695B565@keescook>
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>

On Tue, Apr 14, 2026 at 11:07:47AM -0700, Ackerley Tng wrote:
> Would maintainers be open to having the kselftest harness expose a pointer
> to the metadata globally?

I would like this, yes. It's been a real pain sometimes having to pass
_metadata down into various deep helper functions.

-- 
Kees Cook
