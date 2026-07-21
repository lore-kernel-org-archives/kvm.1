Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8644CF2F
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628657; cv=none; b=d1t4mTEu9T5i7P+bBQ+Hx4jkL8Y+964/xE4RqG6HgMCTCs0wLcu3G44vG8wwY51F4HVFnqO/3E5FPGUMuT5hP1qGQRjlC6ak+F2K/P7AtOigMMsa8WoebOKWGjojctL9Gw8zIw/k20o9tlFe53OKmSw6b3F/Vz6Hw8j7aL6zUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628657; c=relaxed/simple;
	bh=udnHtGFPyz7hbUEOMNqTB0aEs+NZ+BXBJ7nkeUP+vq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJfVcJRMiZXcGuV8K1PDSzY3O9GUo/MQfdzoL5RH+UAxt/dnfgZLyArewtn0gJCoriFiS4LYeUAGXPFPdTzCbL0LU8J8qzyVW+DaKLD7snV5v5iRZP+mQB1fVJGJcgsdJADArusYdkrssk9uu/5cWdKhpiEM7Ka3DiXnPb9ewgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPIhmaxv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAhDoOwB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPIhmaxv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAhDoOwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784628649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
	b=BPIhmaxvzL2I2dLpiYliZUi4Vl3ZZ4XlkVerlgwPOZPkJWi2Y1ISJd0cWs0YAnebMUBHLs
	AswKT4SnUMMdZgdYH/G1aRIo3lrEiBGsh/jpaKC4OAwGV8QtszB8pErhOTs5TBMLnzlSFF
	aIrhryRhmtKfKchb37pLzkWcxAxuFK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-v7ojfCddOyeT990kR39twg-1; Tue, 21 Jul 2026 06:10:48 -0400
X-MC-Unique: v7ojfCddOyeT990kR39twg-1
X-Mimecast-MFC-AGG-ID: v7ojfCddOyeT990kR39twg_1784628647
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955d314945so13359785e9.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784628647; x=1785233447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
        b=eAhDoOwBpbSC1emtGq975/cCLR7x86E2zo9S7vqWiYYwlBhKeW25dzYqQ1vDfrrisv
         Y1o75H6ZYZBHL8nP1N4kxti/xvOd/aXRY7/r0E/12c1EL9+ISag7NJN1psWLzwy2gV+L
         earKLORE7gWxf4Jz9s+wyskK7G7X3SI3XNVgMSUrOMd2hDlbXq8R0rdwCINrxUtl4DzQ
         tE5HapoIGMGPME+EdC0gAQOdjK5s+VldFh1aXwZxCFcB/YaAIhBm4bv3iOhphAzvY2pn
         vqVXXogsI1YrNZaT0Yz2Jds/Ye4AEdIcbwml8q1LMS8hjUhXC8kgROIhoU0Zv5dSHlzZ
         eGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628647; x=1785233447;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
        b=sl2CEjjHtqPubQP2h6zRE6Iwut5oqZWwbNdHQLM9ZsbEuhiop0t3TVfK2nIXI+/KnQ
         QOfzQ7ZcXlXm4/KKo6vMaoEHTTepMFQFJqZQ4UdiA7iagSOZ8VJ9by28CwgEx2/nJW9V
         Th6WI8nw19fWb4sf/2SlUBiAyh3yMD1HPPIG5NfnL5Sqj0+IKYfG6EJjagwGOmLjbu8J
         kfPwdvbgZJOE06ww9p47E+KQy+jx7dOWEijSDyuvVbAB6JqUBZhuT9+rrUPxZ0Dj7Ww/
         QspzwoUgSsHakDHSanFZ7Am1R1aAz1SentiCoo72xFAyqwoDz/FHTRheCcRptmjVi5Hz
         rwKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxIO2xBUPEtmsh6ZfLJ08JFe6zBsWQQOXE8mAY9HqhegkEINkx2Sj4ZZknXPUv1bckTbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+QeYdHRixg3EgVGOkwTiPHsRh4VRBWSxbZDh0STrhxkm1eQg
	j/f5I3A+Wn41xClfXSCpsZdwFDGXfZjjp5yNLEzVWAtJhMnlpqffiIdAyXXsx76k9qNdRadBb1R
	Yo+oEfnJ/hmLUOnwN/IXrlbp12ygNkQHXdGEItIb66tRqfCC0MCYFIQ==
X-Gm-Gg: AfdE7cm4zmjlsQ2FBiPh7VkhgWZZ9eFKu1iR0y5tNqIBoeR00AKd4w/B+FXcCq81dYS
	eh7lum16mlKB2urDAWrmLLVADQo+ZZLeRgrvsyLYXRNh1A7GIFxEtuXq49QJx6fwiN7qR8qMBxX
	2P6LTOeoViUfCYuTuh9qIkgcI5LVSPA7epCVJV7l4bJbuQgwlJSZElUgAAdIMAhmzigIxiAImr4
	V/Yr51poi8BewUmt85lxXtsCOu5KvZWGaHcxSXsdQ2xoZ6Nj2BMBl9iR36dzefmn8mnxtK3rmSe
	2drFbcxZbI5OOsX5Xa7OoPJLW0QcWPbjBKuu2+UrN68xB/rxRUi8knvGHOgvA6TcwJu4UChuaLV
	rdOUceVDvSGDnXPI0B55IplepGDe16P7r79TWlvYfkOBm7+O4Abrg86LcePZsvAuL6GQ/FGdkmz
	LDgQ==
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr194096995e9.21.1784628646810;
        Tue, 21 Jul 2026 03:10:46 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr194096515e9.21.1784628646245;
        Tue, 21 Jul 2026 03:10:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm39599963f8f.33.2026.07.21.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 03:10:45 -0700 (PDT)
Message-ID: <68b5a2f9-53c7-4b28-ac8e-e61a39dde118@redhat.com>
Date: Tue, 21 Jul 2026 12:10:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
 <ak9h1kWcLmpP74PI@sgarzare-redhat>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <ak9h1kWcLmpP74PI@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 11:17 AM, Stefano Garzarella wrote:
> On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>>> From: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>> Add a test that sends 2 MB of data using randomly sized small packets
>>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>>> forcing each one into its own skb.
>>>
>>> Without receive queue collapsing, the per-skb overhead eventually
>>> exceeds buf_alloc and the connection is reset. The test verifies
>>> that all data arrives and that content integrity is preserved.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>> trigger?
> 
> Currently, with the default value, the trigger is practically immediate 
> for packets between 129 and 512 bytes, but yes, a smaller buffer size 
> certainly makes this effect even more pronounced.
Given that PW is quite in a sorrow status, I think a (net-next)
follow-up is the better option here.

/P

