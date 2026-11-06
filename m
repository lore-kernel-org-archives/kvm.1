Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977700;
	b=UhYvgHFKyU9HNZCXqpNv58bA1UZgEOPjr05kOejNmwILu3/gDeAMc5qrABda+yilIqv+
	 rwm7EAMXxQUh7qNti0/RKCn9mOnaizk7L7xOYg47HNGfVWqfqCIf8nojDGPxyEwb0uZL3
	 6Z8KmFWPUXZYg5Jm4FM0w6aQ8D39RnFfBsus3SgNSjD9hWklvvgg8TNtjIqD+CFsjOcdY
	 /96qVwe1Awq5VMcoU/b9sGcQmtMMSKSZEXa8Y83YtB+6JN7xT5Ft1SPbeQLcrFovv1yBE
	 HGsDAe7Tzd/Cji5IZojzM9LHF4m7lV0X2jMflZbARLzDUt9ojgIiDwGf2nDMEaUH9Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977700;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=3vp3q6lh6TXy5on50j0jpxtnhhR94Zm7KWhjqrQdFt4=;
	b=vWjEjw9m1GvTWH2YWA6zTeBDqMBEZAe6rdfjxPQKXaSvM26HUHxx/CrRZ8o2okl+rTrq
	 tiZNixVQBouru6ay8YFApTK9DE1h8o9e0+6X4mang6Ts1RqS6aMZDnJ6jlP81qnmOqICz
	 CZhtZyOwmUSURnMda/DVEttnTfEIDr5DARzH69C+iwNrlOuy5iKM6WXjyzWOoMivkAoMc
	 994PcWOFlvWQEif+8cF+telXUhlKDLXDuExxkqSvMVewO2lN6GIhMynX6ZyqXEHMsZxs6
	 VFjbRLGxzk+u8uJFX5rdU+Nyu7G2mBoUwcF4U6SmiYihDZzfuUHoSPxIjZLBJoCk9xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp1OsbjF;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=n8ufY3cU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA59606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 15:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA59606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp1OsbjF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=n8ufY3cU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793977699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vp3q6lh6TXy5on50j0jpxtnhhR94Zm7KWhjqrQdFt4=;
	b=cp1OsbjF5nUm2XXzP1Yrf4p/Ht/ftqiop6GvjOOGl4yOTchounjZA1+Rgm1j0xnqwivPaA
	IRrczrSqU8P+SLIck1uIBD6HU/o5ZMVnHnN/VzAArz7//Cea7c4osHlz4tgEp2MaRYTTaz
	pYQUGp8oTtbLl96k7BNtzVNRP4P/A+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-AAe6ek_uNCiAmf5j4oMRlA-1; Fri, 06 Nov 2026 10:08:16 -0500
X-MC-Unique: AAe6ek_uNCiAmf5j4oMRlA-1
X-Mimecast-MFC-AGG-ID: AAe6ek_uNCiAmf5j4oMRlA_1793977696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49090fde23aso770659f8f.2
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793977695; x=1794582495; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vp3q6lh6TXy5on50j0jpxtnhhR94Zm7KWhjqrQdFt4=;
        b=n8ufY3cUDQpD7iDSD/RVDVONRIeOFwi+FYM3c1hK0KpkX4vEqP+n+CQtLi0HrO8Uy+
         ExULCAO83DS5QHtcRbad0LKvA/aAYXJkTlle8q4Ha+edNGnGe18RO3Eib6enV3HJPa2B
         jYa8MinYllp86cd9UAkd2puBur2iawLy5sALNx4+FZ7ydvfdOPnqxUTuI5Y6UhAlAb8L
         o8BspxKHKg25nsfWhOky96W7AOZ3QtMoNHhwqc4m/frALtGncQVmM77m7Cvekwbcbage
         /FP0whc9i0Y+jmmkE8csrHxI/0w/EyHpFvSpRaCbBHQ1miqph1pUki19D0vLWW7w9jD0
         1uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977695; x=1794582495;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3vp3q6lh6TXy5on50j0jpxtnhhR94Zm7KWhjqrQdFt4=;
        b=mVDTXf9ZhnDm2KaWuNTVqwykzs5dsPVfb1ARG6s/JlQpSKrAKseJD0BJlS3B4q4Gaz
         z2EMRUvbz3x4itDuZn+uK4c96KybuR5CeN6SlLU8KEAb0qPevkjbLpaNERTrDG8VDBCk
         DsTfBBbHs8HUxnczcrNVwDzahyKB4dpx8rJwBgH13074VI3GT4VfdtDmb1WS5kM8oSn2
         2c93j/H9HAL691Zh1MFUo9P+RU+meCmLCyQnsxz0xty7hrNMjZUyTTyfkCh052FZ+Pm3
         9qJzWyxWsE+iEJbDxmkbTpCrB0fRxkcwycCYqls7ApXz+w6oEF4cY+Hkxg9c6HA+hfnb
         J+qQ==
X-Gm-Message-State: APuU4Z+ucrrp9A0u2P1XDpxPDYDHAd80pWx96622nCAf6aOW8X2NaTzj
	5aqvcE1K/tZbyaV+XzU6BruhtRwQ1BGAxFF8nmbM8UQehDx/UBz18rBtTGsUXN8WPu5yABMDm/n
	t2YtEM4FCCTET4CF8wHQfrzt7u1XCThjJrH+RQvw+2y+uvU4atrB81Q==
X-Gm-Gg: AYBFou1eM2ozZF91nrz0KQ+mCQXoSGRrTknmIWo6DcqJZRcxXzItO0XAPhjZ+SrywIh
	3jwxelCsGvQr/x78jqgOVNXe0lwbqrwhzOQj+PuwUm2bWCpFBeOTis3QTA/m7GWLivTLE8aGSE+
	kFcHUwZB1/s3KqP/fAkS7zcPI/HerVfLwdI9q/dJH8ppurDR7OEtlowAWA6ItXLhYyHl0CoYhFS
	HdfupykwgDwCvA67cf0LtTLA+6TjVbnXqWxtNDS7G7bkgrlcZVJoVnvRzA/aZhyTzMy+fCkTQd0
	fIGe73tedmRr5xaez0DY/8BW8MPfdfnMd9TMPM2j086iWDrrZMV15bOUChbbtGum2Uv0IMwA7+2
	M3wH+sKSwIGSfX17QNJGyhwuDgzpnjqcG9mWQ3VAldjkRDHyjl4a90yCWuWDALon68a+yOup7P/
	0kxaLhfVdBcdGp9c4=
X-Received: by 2002:a05:6000:1788:b0:48e:752b:9f90 with SMTP id ffacd0b85a97d-492772197c5mr5796940f8f.38.1793977695532;
        Fri, 06 Nov 2026 07:08:15 -0800 (PST)
X-Received: by 2002:a05:6000:1788:b0:48e:752b:9f90 with SMTP id ffacd0b85a97d-492772197c5mr5796888f8f.38.1793977695161;
        Fri, 06 Nov 2026 07:08:15 -0800 (PST)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723320csm3831907f8f.26.2026.11.06.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:08:14 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Manuel Andreas
 <manuel.andreas@tum.de>
Subject: Re: [PATCH v2 0/2] KVM: nVMX: eVMCS consistency check fixes
In-Reply-To: <20261105190733.3741959-1-seanjc@google.com>
References: <20261105190733.3741959-1-seanjc@google.com>
Date: Fri, 06 Nov 2026 16:08:13 +0100
Message-ID: <kuppkwihuaq.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Fix two benign-for-real-guests bugs where KVM incorrectly performs eVMCS
> consistency checks on VMCS fields that are supposed to be ignored.
>
> v2: Properly guard the checks instead of simply deleting the WARN.
>
> v1: https://lore.kernel.org/all/f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de
>

FWIW, makes sense to me so:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> Sean Christopherson (2):
>   KVM: nVMX: Do eVMCS consistency check on secondary controls iff
>     they're enable
>   KVM: nVMX: Do eVMCS consistency check on VMFUNC controls iff they're
>     enable
>
>  arch/x86/kvm/vmx/hyperv.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>
> base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e

-- 
Vitaly

