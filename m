Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F422D3ED2
	for <kvm@vger.kernel.org>; Mon, 16 Feb 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231456; cv=none; b=T/ieLVfXF9Qel5eHVA5tk1sDFx6xMQgGjRoXd+Ih+W6vvwnUX35UY01tFEhM2dXTobzZO7BQrRLLCs024On3fI+8/G1N6WaFs4S6INLge3VEqWKah8bxs4zzroNRh20SwxUixnkJqNs6WBfTY5lnOFuICaomTlA5wZjR+3norRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231456; c=relaxed/simple;
	bh=ws7sMDl4qJQES32pQTujpG0FM6TcEVj51QdZ/22NMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6gckpsSKOFzKtLL1keD48j6gH90E1TTQVjzRS0UNUKO4S8OJccFaDR8k2klQdYH2WSilfkUOwNeSoneS7v9g+QKfc+7Y5iilz3Ez/xpAIZur8q91MYagzrTXPZn/cvbAh+H6+NCyc58mncBh0C8iYZgSaBf5MB8wtmG9Y2jf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oBoXBqtR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oBoXBqtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F165AC116C6;
	Mon, 16 Feb 2026 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771231456;
	bh=ws7sMDl4qJQES32pQTujpG0FM6TcEVj51QdZ/22NMMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBoXBqtR87XHv9+jA+qU2eBrTZ3DuGc0rJvGuZ74LwVr9sDjd4FDjuu71RUBfrVeH
	 NQ5/9dkIZD+u/YtBMYgU8Pv6ZmOXE0R4Nfi0mUtmbfsYrj4j81+MmuD56DRVeJj5t5
	 D/xSEmXbHn5Di27grV8xsjRVcI7iDUwRoR27Iowo=
Date: Mon, 16 Feb 2026 09:44:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KHQtdC90LjRh9C60LjQvQ==?= <aleksejsenickin120@gmail.com>
Cc: kvm@vger.kernel.org, security@kernel.org
Subject: Re: KVM guest-to-host memory write / SMI modification on Ubuntu 24.04
Message-ID: <2026021627-unstaffed-gummy-cad0@gregkh>
References: <CACWEi0TePQAQFHQnB5fW_mrFyZhOEokXAFuQv+ToxXvKSbTnYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWEi0TePQAQFHQnB5fW_mrFyZhOEokXAFuQv+ToxXvKSbTnYg@mail.gmail.com>

On Mon, Feb 16, 2026 at 09:56:45AM +0200, Алексей Сеничкин wrote:
> Dear Ubuntu Security Team,

That is not whom you sent this too, sorry.  Please check your email
addresses and try again.

Also, do not send binary attachments, for obvious reasons none of us can
open them.
