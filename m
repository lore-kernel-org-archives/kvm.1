Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C9223708
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362172; cv=none; b=X0JC8taiWkq/90HiH616vb4HhaFpC7sfr/UAjCcasa2+rQTD1vhJlysWLjJAmO+ac9W4Q4/AIRoau5hv7OBoJxWdxgE2UUrli2yqg7B8YYsQyEN3uEw0ju+EsSYYFy9p4DWGXi37YdwvjH9chtWtoMHzCuqbXB617hb0KXu+rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362172; c=relaxed/simple;
	bh=JtNeCaG+8OcXCuj9Ep5QoHr4jhrrpIQAzFtTe/W3MLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSFWqfTDgRMgQAqBP8028I1X9APEMnyfAABDBYJCIcPC/CZyL0Q8NKh+5anrJtSSBhkrgWQVLxQ/NDnDj/WyRj7bhozefJV6VdPL4QccVKAnMajDrQm9aZ8S6K3SrEXvWxcusboeqQ5vjjXSd4dZLGWg0VD2shKDT8dP7MryKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEuwV7KI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3PmI6Hm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEuwV7KI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3PmI6Hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777362170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m3Z0bxHpKr/GBp+i7bDBfFGY1eQTwQ7T7OvqR+qABiI=;
	b=jEuwV7KIiRLgknn5pnb7ZCi+q3xyObKVVcC9UsiFkjWS8yarXjEXeMSLcDN8Eele/2ov7e
	YX/zYg/x3X9Ibwc0knoNa2T/b1/W8rsnY14uP5qD5Q6DE+KqD05uHZ93XG33cvEZstW+gI
	ij35IKbszgi/UsIdIn46AsC8qYgvdV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-jWPnU8ijNJag4g8bRMGDZA-1; Tue, 28 Apr 2026 03:42:48 -0400
X-MC-Unique: jWPnU8ijNJag4g8bRMGDZA-1
X-Mimecast-MFC-AGG-ID: jWPnU8ijNJag4g8bRMGDZA_1777362168
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso81779355e9.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777362167; x=1777966967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Z0bxHpKr/GBp+i7bDBfFGY1eQTwQ7T7OvqR+qABiI=;
        b=N3PmI6HmC8TIrkzqxBOM/wmdJQlRVTNxdOKsnl2Bfz+dJruYSOmWZ3EJMofwa0pFkf
         kRA51ZR1mWboICW8lrw/bRVKmD9Hk4QIjdEWW1Xq30E/iP1dCGNUobblp4G8xgO7OcZ8
         GFrSsucjnimdO01ZxKk5kmPkWOU2qoPDZ/9dRFFiY5vqKWQ5QS569ym5SYxiMs/nYyLl
         /c8VL7B8Nsc8/D7yuLcNqIPtpZtFirWuqjWaSYTaDBXLSqPw/C5p7nzid069wqK9cbTm
         WicQDT+nbDGvEWZYmRqOSZ6q0ogZebyQRSc2b6Ao+6qLtWo/BciJPjWteA56Lfnn+lai
         NAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777362167; x=1777966967;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3Z0bxHpKr/GBp+i7bDBfFGY1eQTwQ7T7OvqR+qABiI=;
        b=jzgCLSKFVVPxeo6+WRhTm04eM80P9f9za2WxvEiTFaWU4C7HEsrB6dwRq6ttdVY9Er
         YO3/rYwRg+uVUguZmzDDR2PxMRbUvGi0SMHHuaslJ4cL8RCqCr2d0kYa3BBtwqeKzZvT
         sNEWG6NiVEd+0QosGLVTy4RhCqST6bhwGxiNfahov45kbDsZ83vpM3cqXoxPEtfOBXGY
         4kmyeBC1fQbaXVdh7Z1WVYREmCFdUmjNA+cPIudpDnf/R0qnA7EDdfywpU2URujn5OHn
         epAyYVpW+iahNGdAkiRLbHJfqWuY2du6ivbmMYNRVQjIHeBtVsoMte1ZXF4gnn6otHip
         Z10Q==
X-Forwarded-Encrypted: i=1; AFNElJ+mRFeWzRDVI5BohsUNdxI67CqAEjlZ5jMpvWLykHsQhaQLctqSm9EpuSkE9JDf2wQpM7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzRtd1Ffytdg125cZ0GaSYDeSh9pgAkN4yLMAoruVU5AGWsBE
	74kbmsnAElzGW+YrMERLe94k8xRjn1rytqsQUlBUGGEM1fa00C/RKIi2sngSworHD0DVQSeA2w8
	YTcqzjTtTNkqC3WLpy4PIaTyolVRG7jmqHQDYmW8IOrIzkqSDIvIt6g==
X-Gm-Gg: AeBDiesdvFca+bShr+RFwrfrURFfJaRT2tTn9fv8dlQM4FSqEiEI/NtkNKjBtuJyxgv
	8QXfVmyDkVf8AHhNH/N5Qa8dpbS6uq/AT10fZJTyNI59juXl3fK4nU9REMCYoywini7QoaJri6D
	a4RsiJHp0X8oCOBIBBUQpGtrnEiY3FmbT0IUSm2GktVY67w9FUMLtLXCG9Ys/mrH5Eb4xctBXcI
	jWuCf0ITruRHhmYHPeCOJJemXkKfPMlv4gKxsSA0Wk77i3YYlFPBMsw6PK+PWj7tk+pDHn+Y6QX
	b6gUzHeGPpoDqm0HVbt3CvXD+3f93xe+L5wylRDncWsWiLyfeZprluR+2CwSuZInrRiAWiYmTgO
	WpWJAHpgJql7GDVuUSfB3wXLiwDzClQ==
X-Received: by 2002:a05:600c:c114:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a77b246c9mr23817615e9.23.1777362167499;
        Tue, 28 Apr 2026 00:42:47 -0700 (PDT)
X-Received: by 2002:a05:600c:c114:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a77b246c9mr23817265e9.23.1777362167021;
        Tue, 28 Apr 2026 00:42:47 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77aeb47csm31700985e9.1.2026.04.28.00.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 00:42:46 -0700 (PDT)
Message-ID: <85d85b7b-5f60-460c-93bf-b9e0210cbe81@redhat.com>
Date: Tue, 28 Apr 2026 09:42:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 2/4] scripts/checkpatch.pl: Create a
 project specific codespell config
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
 <20260427-b4-cmdline-v2-2-0fea2a50a9d0@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260427-b4-cmdline-v2-2-0fea2a50a9d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2026 19.36, Christoph Schlameuss wrote:
> Provide a codespell config to actually let it do something.
> Obviously codespell is not happy about the addition of these misspellings
> here.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   scripts/spelling.txt | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>

