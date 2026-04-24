Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533B284881
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014052; cv=none; b=BTO3P7UHUBa0r8xUsxiBokqJSqBYSOisGFhFRZAu+ZYcv5R+LGBdlk0TXaSh3tlnNT5ZIeQnOKmdu25i+3S8HIzcw6Dq/ewFbLEEmaMVSHj7DCDT8OtJM0BNzaG3Vyoy7OA2azf4gKvjuykwu9OomEr+lsnb7ulISwlcpkLSOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014052; c=relaxed/simple;
	bh=Kgzfk0L0r9AoLwz2LMj5VnL+uKyzTwXzrewpC+Fkznw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vbu3KXy+h0t5xDvBfybx4m7o024WnWrnG8rEcsnvV2PZaH0dQCMPGxnbI5KakmxYCT+ApVnlXX6ZTvVc2GXT3d3eB0wk6Ox7qfEY1RngUDJyNWvjGF/qgj9NmUtqU1rpaDy+mH8l5MpISm4m0JG7w8oU9kPV496styv+56a2w6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4hAjbWj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMq0wmYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4hAjbWj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMq0wmYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777014050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IXcsvT1u6iTDN2qqPni7hC/6StlvrIX4cjsNaY3tTBM=;
	b=E4hAjbWjEpQ6z8Z2FpIby1Wz18P/qghZ+Y/j23u2eWPp59Mlteu9QZgfKks78al8Xm88Ge
	6P1ZH6PZlXEQrzVmXxwKJFxexW8H16js2lHW2T9NwbtX2193pepYZE27Ak4JEG/Z9gr4zW
	XXortCetAuPIfFg5WArY9RcHPJs06Y8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-b_Ej4ijGPo6RNsqZfHKzwQ-1; Fri, 24 Apr 2026 03:00:41 -0400
X-MC-Unique: b_Ej4ijGPo6RNsqZfHKzwQ-1
X-Mimecast-MFC-AGG-ID: b_Ej4ijGPo6RNsqZfHKzwQ_1777014041
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242b9359aso75135805ad.0
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777014040; x=1777618840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IXcsvT1u6iTDN2qqPni7hC/6StlvrIX4cjsNaY3tTBM=;
        b=NMq0wmYflY4zZUUa/9nvPXwTTPBHCyGTa0ehK3eu4l4smnerYpyMvK0bZBMq7jkt2X
         6a97EquAf9QjcAvQYX5M54lpnyxDpUtvQDeuOGdCPNed1P5iLf9uEr7/sg5GdSs1VT1i
         Uz9EE3ufY458HDrJjcWtFXoIGGf1fABhil2mbFaFHY3RSamRyvaNoup2/dn4s/EyQ0kE
         Lmqq2Br6A6wWO3kuFVcniV4iAyVjkcR6Jeh7YdhDbEL11TTwu1qO0rdh6Pd8uJXaqk3V
         iQsSqAZXgh5K14HZBb95UR6bDbLm8/RJWIxFr0UqoRQpnrVAwTB0/0N1mLjZhWnFzaMD
         DIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014040; x=1777618840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXcsvT1u6iTDN2qqPni7hC/6StlvrIX4cjsNaY3tTBM=;
        b=QE6Ica/NaK2b/0K6uslcD40m6xCiNTLX8n+W4RyeLz/CMB8vzr82zO1r5navfzVbxu
         3AiDKGnzOy7x88LlMSrC6eADNK5MXxiATb0RfkKwm/za3oSgWi+gFwtdw30LeYVXeriN
         r0rVS5QBsPqyYutJoJwRnnaggsaFDTu5kn9MqLphp60PhQ9dtW2jenKFf3fFnhQ3kBMc
         TsdvQQvzghzX9sogeKSxp7oy2Bb6mF22s3m/eT3DKbmpTQ+K1K7s+JMu9iZ0hx+D0yZm
         urKQmnK+IvRksRNvdYKLzNHZOYm559iGo5pbzd/sR/colh+bCkzzv0UlMCHXtIlfgQM5
         343A==
X-Forwarded-Encrypted: i=1; AFNElJ+4P7lcVmkZPvyCHjbbibMRrjlIpWInaej+niy7W4mdi6EdEFWpg3P7Q64mEMS2K65zR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRzlxwHB6YqtmlrDgQCbc/Zxrf59HW+pumUgW0FguM880HhUt
	bJXn7x+7bF0zUkJgwBx9JjfLJe4iKm22WBphFG8WRZE0h9f+JWCmV4UTveBb4mVW1f6b2HKXYDx
	fLcK2YdgtGiZs+qHXwdf5Y1soGfIzVp4hbP3KM9ePyoe6JmrrMuFAEw==
X-Gm-Gg: AeBDievYcya5GdsKFTXLN35sf8Q7+srX33WJgeSM1lgeEUTGKw1cSuqLRSesJWOZUBX
	uR/5/K/Ma1bRPbPYXdu9SvLzg3nMTwOPIr3DzeZyh4w7DJoSFNLIFRv3OEVa6/w87wOhcNKBbcz
	4r2Up4yO6Kc8SeuD+ER/lHCfsLXWMtwIGAhCIhVbkEZm7BL0YNfUTqbeN/k7bQl1jVW9N7G675v
	R0b1G4JMpCkFIxVCotH1rwOo6pjDuj5YWCfMFPjHzQwNwo95uB9Nl7t5Lw1KgSI9sdVgmCvYl1h
	cU4Jiq0dRWEikxYFFcu4gPCDVeQjUNdcUA4SVmJXurjA/yua8WVr7VbYNFs//3AKQ4IkH/8r5Ei
	mYhh+8B6jnbUudZBYwhHCcxsbOYj/JA==
X-Received: by 2002:a17:903:384c:b0:2b0:7e4d:f390 with SMTP id d9443c01a7336-2b5f9fb1b9cmr298194405ad.41.1777014040302;
        Fri, 24 Apr 2026 00:00:40 -0700 (PDT)
X-Received: by 2002:a17:903:384c:b0:2b0:7e4d:f390 with SMTP id d9443c01a7336-2b5f9fb1b9cmr298193495ad.41.1777014039297;
        Fri, 24 Apr 2026 00:00:39 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm213674715ad.68.2026.04.24.00.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 00:00:38 -0700 (PDT)
Message-ID: <87e4fcbf-92bd-4f74-9db9-369e4ba8bca8@redhat.com>
Date: Fri, 24 Apr 2026 09:00:30 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 1/3] scripts/checkpatch.pl: Add empty
 codespell and const_structs configs
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
 <20260423-b4-cmdline-v1-1-f72ad0020d42@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260423-b4-cmdline-v1-1-f72ad0020d42@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2026 16.16, Christoph Schlameuss wrote:
> Without these files each patch is flagged with these errors providing no
> value and swamping actually found warnings and errors:
> 
> ● xxxxxxxxxxxx: commit title
>    ● checkpatch.pl: No typos will be found - file '.../kvm-unit-tests/scripts/spelling.txt': No such file or directory
>    ● checkpatch.pl: No structs that should be const will be found - file '.../kvm-unit-tests/scripts/const_structs.checkpatch': No such file or directory

Very weird, we've got the checkpatch.pl script in the tree since a while, 
but I cannot remember having seen these warnings in the past. However, I 
just tried to run checkpatch.pl with a patch, and I now get them, too ...

> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
> new file mode 100644
> index 000000000000..e69de29bb2d1

Maybe add "virtio_config_ops" to the file so that it does not look so empty?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>

