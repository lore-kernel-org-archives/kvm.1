Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1508393DEE
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360507; cv=pass; b=WfijMHKCq/bjIqKeY/PLfkwTWszNQfht2RbqpeEXl9txBEyM6BMXMbhxyOVFbu4jDAOxjcshYBdhm7v4PQqKDLTT0Ip7sOfSR6N3FdORMkI54QzF9MkNNmPN0UKEBP3YIeWz4MakSUtu3xY3NHzvXmfTlShxO7ZKnMXQS1sdUoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360507; c=relaxed/simple;
	bh=KSQJyeEirtbIxNc1OUhfkc7dDnq9LR3hLNcshO1Tk00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEzvPsHHO+HjRdomWe5/5c24z8jpLyXvTtki6uTm81fAOouJ1havdvvikOvYTGE9jUX9ajbwdBmveG+jjHLsWjlSmLVtC2Sh+qp+ig2IvsyRU0EfKGHXYcUfnpnsl76V6blojBRdh7Ubt33NeLwhbJi80aXp5aruAwrIqunr2s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwqNyNcD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3Xgq4y3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwqNyNcD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3Xgq4y3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779360505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSQJyeEirtbIxNc1OUhfkc7dDnq9LR3hLNcshO1Tk00=;
	b=CwqNyNcDD9VHhsothj5HO9S3dyG26hkKt4nTw9Vg9ELNwi3aHrZmKWyEh0b4UAIHhAXI87
	IbJIUg8zKRK7yaU/jEmOBcHLtU2+h9Z/8ivthKIrvXBCpz8cdIckZvRJtwCM5yFN05W3/3
	FW7FhJHQkm4hRN3fafNmpC/IT6mXUlI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-7OZbz3eJNAKgcO70cHNziQ-1; Thu, 21 May 2026 06:48:24 -0400
X-MC-Unique: 7OZbz3eJNAKgcO70cHNziQ-1
X-Mimecast-MFC-AGG-ID: 7OZbz3eJNAKgcO70cHNziQ_1779360503
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a36715dso3925222f8f.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779360503; cv=none;
        d=google.com; s=arc-20240605;
        b=NioCparJfinABHNQOjRfUAmS6x+SzjDhL46ExtcEuUVYoTMw1amF+1mlLaZEC6ismB
         knZ605zgq5RnAxekDlsaN1YW+2FbJvO4S/ox3ooPKCyNyW/abd9+rBdyE1GR0bntly0D
         49JHkR5VuOcfhPuKK8qKkpwd/DPJpepInKaamuApuas3ybEnvh2VjVkBTc1FyWYvAX/G
         jO+ZMT49VyN/dgv9gZBqP/VqL52+YXJ2SF6KVR2g/YGRxMoN5PKSBbsRXNxZ9Ju7SWkR
         ggGYlJW6qfVtvIslqSYnkXmQCCHKIU7bfdfW9B7AbOywH1yVs1oLkSHa0cjdLZAA7KqD
         SQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KSQJyeEirtbIxNc1OUhfkc7dDnq9LR3hLNcshO1Tk00=;
        fh=g+UxBfoMbwzubUFRhH6zdcyFlxdRWq39JmTAIt+QG90=;
        b=OPRhZZcg0qTTzgrrf7EtAwmHkiEvTztR8TBvWNc8UW3Yn7zyhqo7ebFwG599AqPV4I
         X7twYUUpEk3ndov/1IXr3xl1W2IHtocZolxqoJPqAV3ifBKPOX4NJaLurV5bzeBoVBXa
         1NdQ0dli7bRxdzRZR7LUz8EmfNSPL2o1cyBOTFJ2gzNjUuFcUMN6uohRei+q4RqjnVJF
         +4q1KRIzdAL13ZN568mSESEen2iXwgsrJMhFLLC31AlvmVSd5HP+3tUZBxe00YcPc/Mq
         4eFrPy30JkozMxDhBzCqmR3UVDW35I8ARXZDIiSIPplTgzTTvnjBbZeNn76bgX/nGDHO
         hwwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779360503; x=1779965303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSQJyeEirtbIxNc1OUhfkc7dDnq9LR3hLNcshO1Tk00=;
        b=P3Xgq4y3jzulhBK+q9Ry/A4RYRUHvDbibS9Jk/CyyM1aAaVwb58InzmX1gAuv/CGWw
         9CYDLU3bUp3TatEmj8E4J94gcYdngdp3dOFZrvlFJw+OagKj7h06gizDfANUleDGe6x6
         3a2OAB8CnjcvigPX5JFl3p4GCR4RtSeTTN5+YGHyMTbnwYDeo2U0jByhADFWMFl+VMS8
         U6bYrLTYDGm3WUTaczXWjvnLi3ncsy9BredsyrT0q6Z2jmE/9zwE0HCqMY+lRtFxneHs
         /bLdZFjrLnHin5kcasRfXGbmN1aVOq//HFsjKivOzil/NSm6x2JoEzPlOvhGKwENDy3P
         zq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360503; x=1779965303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSQJyeEirtbIxNc1OUhfkc7dDnq9LR3hLNcshO1Tk00=;
        b=PLX9cMOGIbskpFINz8XapNtO2ybt0nw1SCaC4wmvD6sw4WQnwAZyVjB4yh6lhFzcKc
         LYKITwVC9vI07ApmjNPVcb7pPiH4/MdMbpTj4ZndYE6vC+WzDthuAR+CPGc4GFlvsDbT
         Y7h3MFQgQ1fETnOuly+wLih5DfUP5mUxVwI7ETF6ACXQ9cTiPvfK5YQgvssT4Qi7MtiD
         P1rgei8LKg34h/kQaj6n0NkH9AMkVZcXOZWbTuIYTPCHPwh53mTZXRCQQzO/9wNQDMce
         WwR5ZO6GIyXfZKn80wrjfKsppAuppTfP/2WWqyziDpcmUkU8TcP1YCMKymU9nRH4drV2
         qbXw==
X-Forwarded-Encrypted: i=1; AFNElJ/3KPZvRz7e4aSBImlXn3ixvqEfozMRqsejlS+rffTwZ+OBmPIFnUCVhH9RgocBId0RMY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKA7qPeY9VHIVzvyCa2wzxn8wFELcpRae9pPAPDLhLJjpVLBP
	bmYZa218/x+mF135TfSLyZRi36lrHf2BunLyubToGB7YC/sjvT3xVP8+W53J7IyPT1rmNLUJblE
	2ygIj9MQquhY6i3h2wJKANUtOX2Un9sQw3xjirvnEH/EYzgqgS8v2Y6pEYBmHfDaVfLGlG0Ut7w
	R2t3qtkelwMQS2wo4kUDU60fkNjjFv
X-Gm-Gg: Acq92OGj1XdMjCLSCBHkSv/wXUDdT9WE1RuB4/sCoFrpdSf0dI9BLmTLlqDFrj/GieL
	m37CS74rjAaY5dxCg59hEzxp8XbLkTF6b203Ih2HxrdYWXpkafVoeLIG4jY26x18O86xX5VBdTp
	dNIp6NAlqGNYmBEO6EKdMtKIi31SkNu/V5LlXkF2QpD3dmF/38vJqgzh5VfJxunjbyjRTrP+gIL
	R+zeOHuKl1dMcUxGl7OwCOvnSVC6Cr7BDLFwlnDqy6vERPo5MApK8L76XYzcUVvy/JbuVhnb+FJ
	HHRX7cI=
X-Received: by 2002:a05:6000:2383:b0:451:4d47:c9d9 with SMTP id ffacd0b85a97d-45ea3ae9661mr3912386f8f.14.1779360503012;
        Thu, 21 May 2026 03:48:23 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:451:4d47:c9d9 with SMTP id
 ffacd0b85a97d-45ea3ae9661mr3912344f8f.14.1779360502615; Thu, 21 May 2026
 03:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
 <092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net>
In-Reply-To: <092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 May 2026 12:48:10 +0200
X-Gm-Features: AVHnY4JkPOdBZTymVAzmu13X2YhSRSbepc2Uo5zy3bPuPiWDLfYjvOduwZESLoo
Message-ID: <CABgObfayKKDr9birEVn=QMj3Lxi5wo9GnxsSDcZByxEC+HA+Ng@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf functions
To: Mathias Krause <minipli@grsecurity.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 12:35=E2=80=AFPM Mathias Krause <minipli@grsecurity=
.net> wrote:
> > I'm applying patches 1-18, adding the last two give
>
> Looks like Sean already integrated them into
> https://github.com/kvm-x86/kvm-unit-tests, including the fixups that
> came up during review.

Oopsie. I've merged manually everything from there up to commit
0ddb0873cf4f1bd584c0981836778b795bab94f0.

Let's post what's left as a new submission to the mailing list.

Paolo

