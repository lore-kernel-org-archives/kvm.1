Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749539;
	b=EX2cqFwLrQc1pWuzF6+kjNDSsNNfT0YxtEJGakWMcipdhmHBpu7o5ZH6g8LmCCqX6PnN
	 KuZwyKrFu49skYwhk/3jWDF804Vm72c5g/LI2ECpt3yQvl8UgYPy7mwjJl1ZVpm4EOg7T
	 61kxJbKr9xhFX3dFTZerzFsiQl3YtsUfNpwhAp8FP86+0UBXeZeohWqpBHjscZ9VaAwR8
	 R3gsgUBzXAE3znLF2H2UOpkSGUWXoKusjUVgtTxjlNk9ELcWf2Z8lFubkBomouv0vYEJ3
	 b1e0nNfzVne8p+/MeAfvtYNXrLfSTbJqrbHuhcdiomYhTh2Ug0GHnr4VHJwSLCB7MUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749539;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H+0KPtdEXEfXC/zAqspE+7v+IdIQJVk4V6YQ6i7g3u0=;
	b=MWYtBwi+aVhTZEYx8nrgCMGTN5myHJVg7I+DMOjjUdUztFpTsoO6LaQ6azrOJzeYnFJA
	 U/J/CBPF+ItfJQhMdR+7WDHSB2oxT814Uz97wxHfRtmqLG6xXl8Vieo+MmgRX4uuikJO+
	 Btj1ahJ/uzhNfpIHhVrj1N+nb+gYiw2/XMpV2b5KUD/Bwp8X5ONYB1jZhmkOYthT0CpEY
	 X2wT5xH3IBvrLsg4Ulq5Y++XASuQ2BHfDpmlA+UjUGdQPzJn9welYwrQtRdyYAFtynb90
	 wFv4eopPveRiSJJ1kOeeF7iPxKJoWJQTFxANO2VbJemGf1iedNhBQTuImZtT9TlTrnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YHMlUuiF;
	arc=none smtp.remote-ip=95.215.58.162
Received: from mta1.migadu.com (out-162.mta1.migadu.com [95.215.58.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0886606A31B
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 09:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0886606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YHMlUuiF
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y428xEalvyfT4epCMHEwJjAfBxOSoYPKO4WY+t3vG5I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792749534; v=1; x=1793354334;
 b=YHMlUuiFVQzHUTmsbYl1BKOJ4c4ZIiJtgCrPjyE6+pVAhTf40q35e4J9e78sFRB1gCodYO0+
 2jnod23gSLJgTKqLWCN9SbsKFkCOxYpXiEYHOW5/DAYy70kT1ZoBs6yz3h/yoJNucpnmEuLHZ4P
 Hd3jF3JrERGp44Fs5BvwwZA4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c9f2f82f5f5e975;
	Fri, 23 Oct 2026 09:58:54 +0000
X-Mizu-Trace-ID: 9c9f2f82f5f5e975
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 11:58:50 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Greg Thelen <gthelen@google.com>, kvm@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 1/2] chr-testdev: Remove unused in_vq
Message-ID: <atsv0knRRoBCeQSi@orel>
References: <20261022204413.856786-1-yosry@kernel.org>
 <20261022204413.856786-2-yosry@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022204413.856786-2-yosry@kernel.org>

On Thu, Oct 22, 2026 at 08:44:12PM +0000, Yosry Ahmed wrote:
> in_vq is assigned in chr_testdev_init() from vqs[0], but kvm-unit-tests
> only writes to the character device via out_vq and never consumes input
> from the host. Clang 24 warns on this with -Wunused-but-set-global:
> 
>   lib/chr-testdev.c:15:26: error: variable 'in_vq' set but not used
>   [-Werror,-Wunused-but-set-global]
> 
> Remove the unused variable.
> 
> Fixes: b412ad0d39a1 ("Introduce chr-testdev")
> Co-developed-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  lib/chr-testdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/chr-testdev.c b/lib/chr-testdev.c
> index b3c641a833feb..c23fd92a46308 100644
> --- a/lib/chr-testdev.c
> +++ b/lib/chr-testdev.c
> @@ -12,7 +12,7 @@
>  #define TESTDEV_NAME "chr-testdev"
>  
>  static struct virtio_device *vcon;
> -static struct virtqueue *in_vq, *out_vq;
> +static struct virtqueue *out_vq;
>  static struct spinlock lock;
>  
>  static void __testdev_send(char *buf, unsigned int len)
> @@ -65,6 +65,5 @@ void chr_testdev_init(void)
>  		return;
>  	}
>  
> -	in_vq = vqs[0];
>  	out_vq = vqs[1];
>  }
> -- 
> 2.56.0.257.gf7497c7d27-goog
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
