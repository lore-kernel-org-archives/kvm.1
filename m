Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84422A1D4
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878431; cv=none; b=DcCJFfDyeCMrM99/FafbHVv66QOz0q8FyudBTgD5cAfYvZDSylw6yYqObDlRUrhKOnulSCibIegCNPPoqrSKsuPu9WJfcST57hQm411ZvrGIrfwGPghEOnjO8PD6AF2kZHKfq0B4HrNRYBnxzk4i61hsGFxQz/8YgLbritCqKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878431; c=relaxed/simple;
	bh=W/C4MMUxqNaDDLh6u0URZcYZQ7069nzbEieLXj4J8oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfIYh1x11P2lneMnnVvKQ+U0XBW6+fswtBjDxgxB1ObKu5OU8ShhO9mAXkWFQqxEGHrkmlpFwmlqwSX5+YVD+GkrbKumcl/PKIibfTajUejEF1sKQne5e7gW0TXsPaVtkFWlq/u5dP7hekuHyz2EYX5xVQs4AEJPLar4Dvaqi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wiql8HR+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fnfpob35; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wiql8HR+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnfpob35"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777878429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uG25hOfXFYVx/GsPc/rtgQ2Pyoo6AmDB8xreQXKBVjk=;
	b=Wiql8HR+zr9ZCRN1RRXY7BdnvVOBkYDGJEVJrQ9gk7trMDs2LorbPLSQzx/25P83F5aue/
	+6yf1rk0DTOtew8DT6eyH01WQ3rCAB+RWrbSwGR+r74myn/cnISmTMn2Zi2qEeg/FVz7yF
	Hj69yMssHC1R2VG9Qak7LH4gRFjyAx4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-jaZjzf_aPj2WzIL14aQzoA-1; Mon, 04 May 2026 03:07:08 -0400
X-MC-Unique: jaZjzf_aPj2WzIL14aQzoA-1
X-Mimecast-MFC-AGG-ID: jaZjzf_aPj2WzIL14aQzoA_1777878427
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so2012341f8f.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777878427; x=1778483227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uG25hOfXFYVx/GsPc/rtgQ2Pyoo6AmDB8xreQXKBVjk=;
        b=Fnfpob3596ulcAnI/xiYNlCFHfG4wGK1+g/9AP7c4kWm40P9acBEkqBCdi8z6/PDUp
         bU33bP3Zhwo2prYsIMjq0zyLPMSmAiXv4U7b5EBBYVIgvYs8pSDMzaHSRMq6ODbhhTB/
         wIf8hQ+k4dTkfmSxvDPi8S641NOdWc9JLzV0YY8FdLJLWsuWdjW9/WhnUYdIIXgcumuG
         BiKL9UZFaLfM/+/uGvSoYdguCG1o9r4FT3IWEwUoRQBiaUMehvuoL1HGUnseEyC+lH8N
         H7A8XEt4kNO8d+aazmXhIQ7pzVf/ojl6NsvT25mFnEhNAvPYYAmCkbmtAJpfsbS7Rw0H
         ri+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777878427; x=1778483227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG25hOfXFYVx/GsPc/rtgQ2Pyoo6AmDB8xreQXKBVjk=;
        b=dq1qhxWwkk3wbWGFB46I59R4yebRS2rWbDzWL5BVD4HifF9TWqfgw+JKtZAJOFqEgV
         tMvvjMjtoDKfnLkT7VkS3qjxpuv7MtEDgG57F7Q7Ik8O1dXWemfd+5bbElZtaagxGtNP
         Y0EmeT8RBeXnNp6AbtYqY668smj6GGWI58x0gTWw3vSvRrFksvOnUHOr711ihRFOCjGT
         knXJqu2nf8AA4RJvpJsJFqP6DbKkfrzAcGhKj+/PA5yba3UQC6vk16t/ioxJmgwFUeNS
         kB92Ai6SQH8XtcusNGHyJhih/MEAPXWDtH5F1pZwxk0/R1vjDMUy6e3q0Yy+p7SnDcdn
         DQVg==
X-Forwarded-Encrypted: i=1; AFNElJ+Enelc59XWGmfNVP/BowkPLLTqwm0Z5+lt8C6UKeUha50SSJd25mdg3f4mz+kXKUd5r/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZB6RPKrmXqYRwTArz0jmx0TYZWLyNkeOpnGFWnsbcMHscj38M
	/Uw8LI82o1MAWKGcxXEI6WAU3mhri3VkwyTHZnM69+qhepch2ekI4qks3D34UL1+hqK4qnVFXBt
	0hXCwEtobJJNufvgZgS4s8mLSTM8r4F8fzDRfpJGN8uvnqgZcW7wWIQ==
X-Gm-Gg: AeBDieske5C6bKqYkE3rD39cYIas8ubYyouyUxt477ePv+a/7MIjXNy3qHWqXi5ZP6G
	6VwB1J9ebmFw++VUuODDPwqV4SBKupMf/hok9nKVi7TZZL9V05kWm3qy6yVZqRnA5Mac2ncAFDr
	zgsevoWiyA+2IrlFWZaR/SET6PCS7VafUohnbL29a2rYs2bFfYi57lilOF0BY2aJ8DivgHIj0WU
	FRENDxcFmy1thchcMPcfZL8mhg+Z81yBCgdz9pi6E6+0SpwmK3VCbNJ/N81NNURYZLSKOKPlMXF
	nvyvNTxtshDcrGgrXKBRCCErnAzYbABC6TEEnEXtEdhW49HEO76yT6AoYrcucxaU22JNBWxOHx8
	fDenKIB+ZNUAi9+M48/lwC7vzvLfPyw==
X-Received: by 2002:a05:6000:178b:b0:448:8db5:410b with SMTP id ffacd0b85a97d-44bb5495eaemr13216390f8f.20.1777878426795;
        Mon, 04 May 2026 00:07:06 -0700 (PDT)
X-Received: by 2002:a05:6000:178b:b0:448:8db5:410b with SMTP id ffacd0b85a97d-44bb5495eaemr13216321f8f.20.1777878426300;
        Mon, 04 May 2026 00:07:06 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f424032sm23168129f8f.15.2026.05.04.00.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:07:05 -0700 (PDT)
Message-ID: <caa06e26-2d72-4f67-bbe3-c35ece189760@redhat.com>
Date: Mon, 4 May 2026 09:07:04 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 0/4] scripts: Configure and update tools
 to allow basic b4 usage
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2026 19.36, Christoph Schlameuss wrote:
> Provide some basic configuration for checkpatch.pl so that use on the
> command line is less confusing and actually useful.
> Checking new patches with i.e. 'b4 prep --check' will now not just give you
> dummy errors.
> 
> Modify get_maintainer.pl to work when called from 'b4 prep --auto-to-cc'.

Thanks, applied now!

  Thomas

