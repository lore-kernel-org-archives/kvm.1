Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A829827E;
	Mon, 25 May 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722384; cv=none; b=VMEPdyRKWKbDwLpvo2jlHMAaf8gqvHbOftnv/IRtGCS4yNYbegHU0ejdrZ+kqghl7pquVVsCMzeqlovoIUY+RRHh4UNAdtyJ5Ra8njA/QxpDDPiXyfEYhVYm7F6WXJpBM9DlvGI4qscw7PswYzqVz93mlmcX6khPEMdocWwW5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722384; c=relaxed/simple;
	bh=VbqQVRULhxHGq6li6Gi8E18YMAsjVjByLeQh9G/U2JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFhFJPv1Ff9VlK457/RB6NcAvFjAHdcgl3vqZiEOfruLaJpSDFvHf2DbRZaR6wLIF2HnfgVT/kLENm1ASzO+iHgvtgcflAAAGKaWQJgCKhBy9LyevS8KWA5imxVkEBccF+ynCSJw7g7+JmAdhHFCJO9rP5+MjG1u3IEwOxBJ48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=t5iZPTVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LvvWtHK+; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="t5iZPTVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LvvWtHK+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id BCD2A13004E9;
	Mon, 25 May 2026 11:19:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 May 2026 11:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779722381; x=1779729581; bh=p+fmVjGYU7bTYKBfSi8JXdSR+0SLMTaX
	Tvd5eVBiWdg=; b=t5iZPTVdUYy2gjJM6u+f7g13juYul2nhHeyx1ZN026RU7Ifc
	OAIsvHPGicnjSQCjK0b2OIkO5xgHmvf7OkPYQN8hvS0tHlVQBhwJVHotru8LEiaQ
	ouPF4NQdxQIcmApSKv8Kt+wlg7OgRWLV7bdmwrNvUk+XuQqs8hbQl/SSUJ4P9Zhi
	TLMDBMKktWtDxeSQkYySZI4eGy+XKsFuRfAzZAhX4JRDkbuoRDvnoZfV8Wdy7fnz
	aVWHWWL8+NUfv5hHdYd403ywHWK8w2hxxhVxDam8d6xbYDHOJefOuOAbpdRqXMff
	B67rA8a6oIs/XzGxwmxdKwvyuClg3SHJw5rz5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779722381; x=
	1779729581; bh=p+fmVjGYU7bTYKBfSi8JXdSR+0SLMTaXTvd5eVBiWdg=; b=L
	vvWtHK+I1ufwGppJp904MfdYVWUWeyTs0/OjnM1E1bHgnuhEn8ut9/l0e7U/wJxI
	+B92c2Nsq9mYwP4C505mIuce5pcXnjVO8NjKS9qEv/vo7ywHk3ez34ZarCrJxC/G
	G21BWWWeV5xTF28wu/i6KdJri9pxJ61/+pT+bYlbElWb/z3oUn64r4RqoPNO0sjo
	qG/eXme4QjgLYdRrehJ/4DSVqbEFZafEwbfbTqNLu8YMTo6qUQEsQjbhr0zIIesk
	A9/GkqGrzPDH06Hx9UIPNEF9Lv5+wTK7GWqWDi62TYcUhHSLcfu10UEyABxVHBOz
	vI9thrwnkRUocpPt1Scjg==
X-ME-Sender: <xms:jWgUaqXiTdJCGU5QNGCw-CXwtMDnurRrylimwdKu0qoYdrm7Sa4BLg>
    <xme:jWgUau9GQ5BCyt2CjVHYd7YSGSwpJDIFIiZ5y7TaCd3-hacAj-UmstbmZ2zWtEJ7_
    oPKOWovY9A502xMebjfPJb95_4UMJ0ySwIL7Vu3C9WYW74S89CnJ90>
X-ME-Received: <xmr:jWgUaooz6yUda5FVQzdGb6zTkbvvSFgvnVAmqhSm_m-Xi1-JFp78lb5u_jBcfg>
X-ME-Proxy-Cause: dmFkZTE3s0UX/p7Y+57GSix+5E7MJLV/+LsbqZvWSahNkNt4SjbTSMKpWb6koVAVGcaEvw
    hYXcOV79w/z83CC3VSmntG/LsIxf6d/Iuwh2YxHogqaalA4HDpe+wDf5JWdAZNJyXw4fwp
    QS+SC6TFjNPeWwjEQmA3MM3MGVymfh4tHY73r35pC7p5ziCMKaVqTC8p7NY+eUux76wU96
    WGtheyWb0qJPDVBQy8wVfThKaVFOzjHxkT54nB1aZBPzBuXY3ejgAj7FH8HeLAtbJR+bUy
    dP/7mOVCBcrXRaxrHp0uGmq3f7ekHavBCwAZ26yzsjpaext8EmB/McQ9c5Z2+HB7k5s5c5
    ZQYkW34v4wJJoyhoi5v8nRyJvc2guzdJ+BAIibHfWZjoLtUkfUelOmyF5ua4GqD5+wgna/
    beUgiegHroxJ4koA/KcZFRxM/EFbGBcYFGIwl71srWTHKOwPEq0kOK9MKqb3O9Yqa1cOxN
    vCiT0PwGSwiYw9UAqQ1sa3WL4ZSXlQNRyWw0yu2VKL3WQDd8uzVWB+0TXNncSc+jBB0FI6
    J0ck1nw+GzqlhQupDvK4l0hvpnhLOa5f7q+YNZFc18HDkrB8mQTs5Q1Ccf4FdnDHBqqgZx
    kUdBHZtKtitgksl+rgECzwK2FV2kpNyul7CjaTKor1Y/UKbQ28ZtJB4mvLuA
X-ME-Proxy: <xmx:jWgUal73ibyRK9TJtGZtiGqghxJ9kbJ4YyBfl8T-TJaPbILKWj4pxw>
    <xmx:jWgUah5GrJ9yc7vgaJilgZX4y45NeTSGrh-G_w4LcWxi5maVgjZRoA>
    <xmx:jWgUasmuXBTtjnIS1WoB3bNVaozC5RDzC45-tgHoMNm0JAwOj1eZMw>
    <xmx:jWgUagjpWc5qes8NA2dkZ9ygiXtXFl5W4LTKMBbrH8abRQZeJTJ8XQ>
    <xmx:jWgUaunxutpBWCeDb7X8kIGkEJgL7BG1S0FqTNDFaK1Kh--rGYlAeF38>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:19:39 -0400 (EDT)
Date: Mon, 25 May 2026 16:19:34 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 08/14] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Message-ID: <ahRoPjww-xTjjl3O@thinkstation>
References: <20260525113737.1942478-9-kas@kernel.org>
 <20260525121111.E857E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525121111.E857E1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:11:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Page tables are accessed and modified under mmap_write_lock
> without first draining per-VMA lock holders via vma_start_write(),
> risking races with concurrent per-VMA readers.

Confirmed and pre-existing -- the pre-patch path called uffd_wp_range()
which has the same gap (no vma_start_write() before change_protection()
either). Will address in a follow-up that audits the userfaultfd
register/unregister paths together.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=8

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
