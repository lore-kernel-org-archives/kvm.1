Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713213;
	b=Ju23aUFglpJ7TzY9wzpp8FkMBA8/NGgq7q4Y3hjOUAcjRpOpPaKxBHh3jZzVYBnor98i
	 ZqIPp8BuhSQmH8V/h0EzGTQsHeCz8V01s6hQ5N9wogLVh26A/5+WL7I3W2H6UuNYYZDjU
	 VreM8rH1oz/jE83AFlw/7+v+MnrtkGTvlWUTE9YOkYx2SY7cu4ukJuA6VGej/JhErc96y
	 SfXptVMxc0MnBGtVM+EM/jjYDd5ogzvAtdxWtFudwEoYzt1vMs1qAIf0OLAtep3w+3+Oo
	 TpqBxUgYvZlxvVhE8M1Fhs95iiFr9qM6CwA44mww4DHWidPPNaIcR5hvHaqFPIOeMKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713213;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
	b=1fcWJaqtei5TCJ2GwhqZgoj3E+myxgbCw+9EaXrE6yDOEdMsU+DSHq1kBT9/4CBHHJgr
	 axXgAlcYOuR7pWC0oVPAUcuyJ7ss4qKdCrC0KVNB//nsVKhvfU5r/Vn0X37qaE82MpHEr
	 gfUtWD4V1YhfqM8EeNOVq+qYVUMg2p/JitQjQMGPRe8olGutFIjNcZiK1PNWJT6ee0fth
	 DCytyD8RslIU9VYHNdYXQasFI8ADijUL94/X8eU4Jj1UZSKpzIl+TV7f5tnSK5UA8TF1Q
	 P90iDTHD3WjQ+acuPSvayMsE1SYFk++j57fTbPOFBTqemiEs4MucvwQKper51Z/4XRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P3dkMG1t;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ifb09G6v;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC68606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P3dkMG1t;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ifb09G6v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795713212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
	b=P3dkMG1tJ52GaZ9RdXvIbyzVRDnVNo87GXzBvTMMnv1VYPZDRYytYEtlphqOqSxSvQwy8Q
	XHR3A0iSsewoePMCKip07VNzuDedTwgeMsB48h6gi5z3q5prwh/C8n03uGXP64hvKZWVnq
	YNDJdfAMAFXQpnq4sb2uO37CxfkOp1c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90--LxKEExpM6WqNAHcnwWCuw-1; Thu, 26 Nov 2026 17:13:30 +0000
X-MC-Unique: -LxKEExpM6WqNAHcnwWCuw-1
X-Mimecast-MFC-AGG-ID: -LxKEExpM6WqNAHcnwWCuw_1795713209
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb67b2c00cso41660095e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795713209; x=1796318009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
        b=Ifb09G6vSuvdI+a9QRlLN50N1cD0yqDbyCNI9+m0SHyrKsgF06ztDvTka25bDfUvnk
         UsiZGqU62cilyY4vO/9OCjJemgjoGPiINhY6QxYYV08OambzZcvjEmNzxysE3DKmcdEQ
         RJxnPqAiZsEo9E3V7YRWzfwQj0C5tCSj5i05SgwXV7EblF5ZxeUYSlkU3SkBrUyqUbUx
         iuX3qWgN1/xjjBHL+6/CJLtX5jfoYn1sLE3fUnDmpNGqnc0QT7FRGR46p1LKvDWXp3bk
         xyM0LT26+oqkyQM08dVv3hImGZC+Bx0UXtQH7k2GnZ8buuTdyBIwkJ8CzesKe3HOnByH
         aGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795713209; x=1796318009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
        b=NvjCobdP3bmM/l79DWgkSQaIK0qK8vsHSX3TSowzTscIwm0RjBbYI2M6T2FbIrbtqy
         n0Gzf8e8b3NCTbN+z5d6PG1MVhUD8VnFd1nfmJQvBefIPLtEovYJthdMyGEmAr7eZC4J
         qSfmC5zHRo0SaKqd/TbQsadraQaDoDRWv1q8tE/jGKytcAVMR3LAuYbXzSvtcVMPMfCN
         5O0wPBVHOA+WAygQXToVU4dgkHVa/Mg2sCGjRcKG6pXoOmHSQmGTkniTNoxzszkHhbSw
         dBSEUxTCmtDkOqhMma7ZNQAY3MM8FIKUiMa4ZpoKUVRSFLQia+8A+LbpzaxsElTwdr5C
         Z2KQ==
X-Forwarded-Encrypted: i=1; AL+hErEJ84zGAfC8acTGyCLD83/NlwLyRN7IOV5OrRBaIeIMACOWIvoBYCpG5JmPX+zS+Cai0jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2Hn4fwUBhGbvZFGo1CRDwhavlhoyAVohwfy2O8tpD6VNL464K
	VaT+kGPSjbynqg/slCVOIEXEgjLz9/aOA+YMjdEaJtFivUzJLCOmAJOEFGuvJoTsowhmm23QTUo
	q5Pks98fuT3mEs3h6W6bmoyd6WfHcirsX4dBUwTbOefK4oWbYNOnzlQ==
X-Gm-Gg: AZFdTZcanbHhs+xDCcztvXre67UWvIHZRvjce04+uQQQgaIG2zHIVeWb3YcZ4MDor9U
	j/qPJejyH14kHXOvhgbHxsbkYYI6C+Wylau+Xexhr/bqbLTgPNfak1YLMETC+WZ+grAcIUqaz4U
	nOoAnF6rBWqUjVM8kfrcScbcsOX6Qf7p5oezuxgGoLMstjhFbQ/vDe24wiBLRM4JTO3Ud1p5oVe
	9IRb5uKFtm55KedSzxA2LEwjo4nt6tjhs3PyAOJKrBQ7LULibKX+JiYxXhWN0/9qUW5GwZWUjmI
	4zm0zt4crk0gxMWZFkriW62ly+LdhqiIydF5uCIuSOknjNrAKjk6DQXf1gTYzz4tZBvDnq2aOjt
	/1m9p/YAKTe1dwV6j18kDxhcScYUGYl2fq2CoX9ZyN3eHjo1HNgldIj+k/XjMMMVopi3zJNAbDG
	faNjq7kLfdU+Dh9ZWP
X-Received: by 2002:a05:600c:80c1:b0:4a2:10d:5e0d with SMTP id 5b1f17b1804b1-4bb8615a739mr336371015e9.14.1795713209199;
        Thu, 26 Nov 2026 09:13:29 -0800 (PST)
X-Received: by 2002:a05:600c:80c1:b0:4a2:10d:5e0d with SMTP id 5b1f17b1804b1-4bb8615a739mr336370715e9.14.1795713208866;
        Thu, 26 Nov 2026 09:13:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9? ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm38213038f8f.23.2026.11.26.09.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 09:13:28 -0800 (PST)
Message-ID: <fa7522a1-1d0e-4bdf-aad9-767c08878cd1@redhat.com>
Date: Thu, 26 Nov 2026 18:13:26 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
To: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Khushit Shah <khushit.shah@nutanix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, Eric Auger
 <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <8A57A0C8-9E85-4BAC-803A-DAFC6DBD6612@nutanix.com>
 <20261126062002.136401-1-haseebashraf091@gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261126062002.136401-1-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Haseeb, Khushit,

On 11/26/26 7:20 AM, Haseeb Ashraf wrote:
> Hi Khushit,
>=20
> On 26/11/26 11:38, Khushit Shah wrote:
>=20
>> There are many such fields like PAuth (APA, GPA, =E2=80=A6) and SVE. T=
hey are
>> not part of the SYSREG_ framework as there already exists boolean
>> properties for them.
>> (Another way to do this is having -cpu =E2=80=A6,vhe=3Don/off property=
)
>=20
> The v1 series was closer to what you are suggesting: it added a
> standalone `vhe=3Don/off` property and used it to select the
> requested KVM vCPU initialization mode.
>=20
> Could you please also review the v1 implementation?
>=20
> https://lore.kernel.org/qemu-devel/20261121095636.289814-1-haseebashraf=
091@gmail.com/

It is a valid point to question the addition of new vcpu properties (espe=
cially low level ones like this one) while we plan to introduce those SYS=
REG low level properties. For composite properties which stand at higher =
level (tweaking several knobs at KVM VCPU init or IDREG field level) it s=
till makes sense though.

Until now we have proposed for the host vcpu to expose SYSREG props only =
for KVM writable ID reg fields. On the other hand, named vcpu models requ=
ire to have ALL ID reg fields exposed. If we were to extend this infra to=
 other archs or TCG, we may also need to expose ALL fields and just have =
different implementation for setters/getters depending on the writability=
 mode (REG WRITE or VCPU init or anything else).=20

Thanks

Eric>=20
> I changed direction for v2 following Marc's feedback against adding a
> separate property.
>=20
> Thanks,
> Haseeb

