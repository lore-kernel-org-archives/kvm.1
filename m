Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B84418EB
	for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121537; cv=none; b=Qs6Sm7NOw+TbySNclWtoG9AdaAy/wNJoxQJ+aPl0nlZH9qUIHW3yu1bGDFLEObnuXuGa1xUuBQsx4/Z+n30AglCjTvO45iAEwUCKc49b3Bqpo9klpL1I/VL07wy0lAmtH6JISk/Yg+8yorUDFY0MJa4nrUUGpN1+un80BXBWUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121537; c=relaxed/simple;
	bh=pVZHWg0t4JXbIDil2TydyNQYwETXIrvCJILBi8caDGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACS0qEWUXu4CU6vFAQzayaFiTCFzPAxScpko4lmf3jcsPp1OfISrc1P2mpO5HlfAJxadbcPjiSldjJ3zC1BgehaEhg65fp8bi9NudMosT9iAaFpdahxl7aCY0WKeUWGVA93aBMS7FBNW6gdzRWzRNXKjT3Lcyw1sjK+GFRQAfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czu7Ms8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czu7Ms8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AEDC116C6;
	Thu, 26 Feb 2026 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121537;
	bh=pVZHWg0t4JXbIDil2TydyNQYwETXIrvCJILBi8caDGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=czu7Ms8/1jtt1vZDh8kAIGj68ekdy5b6FZeBSsBT17wMmzhYDxcZVnvTtVL/PigGa
	 S9cnEGQCwQXokZ4uo768XoC4YpKb3zFX9oHipf8PZN9zsXN7sJSGKNvnFl2rz5/5q1
	 SS+evB4lINsFVdCV4wdMMTz+hBs4CK1Xb1mEitjdOP3rq47k6ep4xgWP9Wv7LUzmmw
	 yTO7rd5LqYynvU4v+Y4MLwnsztv0q8sWbRwVR79bh/d+H47UQFCpRb6VaeJ1D+fbJb
	 GDAaty9duIiftGkP2bmG/qBJirwqG16vdFlm0NiA/VWsbHoUBk0rmTH4+U3whukgs2
	 Hxqv/jdWw4Qdw==
Message-ID: <cf9520ac-de22-4fcd-b966-a9cae8e56c7c@kernel.org>
Date: Thu, 26 Feb 2026 16:58:52 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] system/memory: minor doc fix
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-5-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/26 14:59, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

