Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB2348452
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780183096; cv=pass; b=Gh2kDIz3Yy5XpjSv23VEyZaoOWiniK/EMWl9TMlAjYw2v3TUq2s3M59hEAMKwMMRkra/xyAUaWhRFR4x4VD0XMqzs4YeJZx2UHKOh0NuzfVvEEoh//794Bw2+e1uyFzw5DEhNhZKAWXJTM7QuMnawAJeNzxNjk3UeAda6vMLlXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780183096; c=relaxed/simple;
	bh=pOCooJF2G0ufGgtFaI1SVT0I2BOsEPBhROLlgIk+x3g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiQKLsxZxWNUAa9GZUqX0QdY/1fm0qqqiUR6k9hCLy9ZjckL/y5o+IIJInMfgmy8BjiC2czbJ++E4Zkcw1zyvP/3zSTvcn6l6qDH8+zuvcNZM5Yb0bAek2nnCOjXxyzz7T3GW6VOuGPNCAONnXYl93v6r+aZAMXAH7adeuEixck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaYN+GrF; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaYN+GrF"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137d452574cso380115c88.0
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780183094; cv=none;
        d=google.com; s=arc-20240605;
        b=YLJr8q6g6QUeDfBrf4TZ/y5UkJt9IpGZ+CsIKQcx1KTVkNSnPXrXK8yRFO9gtXIacn
         3DtdBJ5sHhaSOAzXVwn8xdgUIwfLdgU6ZZGyIgxuqevr2eH8dPuayTTzatQI8luqTI2Q
         7tA3JgeC8EvX4n7MpmiMcdIU1WBqSn9OURZ5eXBL8Cmd550i9lDoEpFU/hRlkJbhDCSv
         5861el/gQS7Q4jVEpEhKy3U/LkYnJzfwshgtVV552EaGUVWgIP4IJ3Ejh0vddLExT7Ah
         1GjsY7/1QoIwrH7WAlddBGB1QqB//RLXokkjG3OwMPpMhz4I3ZpQthbOVEIRJuKEGyJs
         mB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pOCooJF2G0ufGgtFaI1SVT0I2BOsEPBhROLlgIk+x3g=;
        fh=a/B0iV5LWklS7QUR0cRnqbJdAtXzyhd2Xbve3+VFDMU=;
        b=NenMinwPegb3ONg797YXl784PWrlSEEhklMMzpDOVzCarSaEi/2ho9mJkmtz26U4h8
         aLfIUpNTgQXnYkoq2yc94F45r2hloyWpFLq05meLuXfDgbkYRfgxX6BpGD+n7ct/GmxT
         hzpHIx+rFwK6ohJhlvS/Z33RgK/Mdk/bccElR4dmzMXUjBihtbjvRQKsoC21EFufBaft
         DLqPm0i87WZKXmcTNfp9BSIHkQdGElnOU03LP9jS210EsBRvRC4NZNZAP0egjgWY9fkf
         aC6jbOTjJEVf4OWw7NdFq5nm0ip5ae/gvpAKjJ0OYmOrlnNrwQvktbE4Q1uN39OLG+qU
         b/bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780183094; x=1780787894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOCooJF2G0ufGgtFaI1SVT0I2BOsEPBhROLlgIk+x3g=;
        b=MaYN+GrFPYdzVnMeG4+P/wSLiLRnbaHL7qM+vvyl82liV0GJV9DH5vjumZ4CkYBcbd
         lvJhuGGFWL5k+Hxcx66siSKiQIHWtgfU9SWhr2K9+SsupPp3p9Gzt4rJONsCo+Enikkr
         AouWF7m6mLQoQIx35+zJ9ZYcioTCqFpLGaZyOWKNJ61n4nTaJTFqmwdBAQkJwEQ1o3mi
         266jy1G0tsT8bSZNdjDyKqgZbwt3/0qyBM0NApScZwE8JZ+28sn9PM4BJp8p0FcGEnFG
         BQEsLZ3qr3JuWEZiyX50uuteB5My9c+Q0ljOgSZkDoxFyXufj7BhEasMzAXqLQOiwVlj
         LhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780183094; x=1780787894;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOCooJF2G0ufGgtFaI1SVT0I2BOsEPBhROLlgIk+x3g=;
        b=sjnDeBsbD42Z9Ml5jENkBCcvUnSUPZYIyrXWXOy1r3cRM1fHB827oaGzB3lCNA5LkO
         rwuB/RfemVKsd3NdAVI9Az9XphelnadSZ9qAgOOz/3dd9G4dme7nu0AYZJi4TdAdzsf+
         t0BZ2Q/cHvz7kV+skMDAwVBLoMbf6qhh72ifxByDXEcxtmvSnzUeBlL62ZBFpClUBofV
         bIhN0Zj7MPEmW2wJwxxhZgWGnrTVoQ1O6PgAbSVsSfBScdq/518WbK8yYUH722bHmnP5
         AX+TNjY1DvkRt+H7OhyGB6Ojz/dkdZk6BVRqZa2WYA17uzzw1dbHaIEUixNR7SPGhPof
         siUQ==
X-Gm-Message-State: AOJu0YxJSWwcjeh3vEmlNud16zSmdzkFa4jfyFUZvemXjbvXo5gkHdKX
	tf4ICYHjEw7pznJr/GLyKtQYStPMLW8bipzyPAXtUlN4BnNSpzmk07w9k6TAAJn25J2weyqc0U7
	BZzld3NiMwMLe0BLnzhdC3fMnthg+J5gZ+eitkL9k
X-Gm-Gg: Acq92OEEgD5/AaVVgwf+o98ed8gVspdVAQKhYeMd4sgIKNjXwCAi/zUOZRxUuq2lhqW
	RXJNILzi4N/5A36SwFgCBt6Q+CTmTP8o7XpPukxTrhAXtmwP07+4tBlH/JrA0nk/Ok3GQYzORT8
	pQjvN3nGcIISGaEicPMb4CyoKJ6ZyyITQI2EQ809fsZRvWAu3B3JKcwxhH98XiD0BGzFIjTaAjw
	5RD4QbTNkOfCutNi2ZPYaD8fmoY03zBJrXY0VeX/FvQW0Iw3Axc2ezJfFdDTVM6mAJJP7cyeaSB
	5l9ft0SpX/FbmdyKlG2k37MqBXK+jqXRMcEGYJyJvsJFs27Lk1+T0POD99itzo7x53h9OvW62o5
	7qiZcaojZ
X-Received: by 2002:a05:7022:61b:b0:12d:b7e5:a691 with SMTP id
 a92af1059eb24-137d4026bcamr2334754c88.7.1780183092876; Sat, 30 May 2026
 16:18:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 May 2026 16:18:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 May 2026 16:18:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260528021117.107984-3-seanjc@google.com>
References: <20260528021117.107984-1-seanjc@google.com> <20260528021117.107984-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 May 2026 16:18:11 -0700
X-Gm-Features: AVHnY4JFi4yFUmEM5YzAWCInUCEqepgJpEBx7hqMxEmKYQDMIUL_zLuvPh3PhJI
Message-ID: <CAEvNRgGc2nASNKhUevRY5yNH=drNTh0eX6CPcjPGJicBNA3vnw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] KVM: selftests: Expand the guest_memfd test macros
 to allow passing the VM
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Expand the gmem test macros to allow passing the VM to testcases, without
> needing to plumb the VM into _every_ testcase, as the vast majority of
> testcases only need the fd and size.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> [...snip...]
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
