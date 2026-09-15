Received: from smtpout1.mo2.mail-out.ovh.net (smtpout1.mo2.mail-out.ovh.net [79.137.123.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AE3C1D5F;
	Tue, 15 Sep 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.123.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478540; cv=none; b=PsAadafQsaU6xnxVU1mgZU1ZKbDEfQ3agnAJ+vtOLytFMCxXaifNOwbx+Xsyh8cuQiVjreJePj13h/T8tw61U6OgiGzShCxxgk9lu59sO8Y3Den9DVHYSb1i6WEUfeRFMAtbdnvNCCqqa3vUaMOY/88m8J3jQF9llt2ajGOKnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478540; c=relaxed/simple;
	bh=fjkxha1w+DbRNLwQvMI8D2L1jhJNUKlbrJxlN7jIlKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMC8n1doZxzFvhXzyM9pT5FUlaU1/Pm4FpwOU79rSwtJXrpZlhxM6NwsVuxHc48XqdSsNZKbJ14xMqNAXOrKl18BOzs2GJpqbJg4RkwzvKTbZD+U33gkKu98p8rw5C7qSQWYQulqD6lkwLA5BUsAPue5K0O7C9mTwz074bhcgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net; spf=pass smtp.mailfrom=guillain.net; dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b=IBJLAyxs; arc=none smtp.client-ip=79.137.123.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b="IBJLAyxs"
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [79.137.60.223])
	by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4hkjBk6b6Bz43Bd;
	Tue, 15 Sep 2026 13:13:34 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <spawel523@gmail.com>; Tue, 15 Sep 2026 13:13:34 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.192])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hkjBk5GhGz1xpR;
	Tue, 15 Sep 2026 13:13:34 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.7])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 1BED99A1C15;
	Tue, 15 Sep 2026 13:13:34 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G0033130615f-ceed-48a1-8e19-f74172358026,
                    92EFA8A7CA5D864B02AA08C4C94B13685DEDE1A8) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.242.135.166
Message-ID: <ace9a9492e7e0cacf854af610854764c566aaca3.camel@guillain.net>
Subject: Re: [PATCH 0/5] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Pawe=C5=82?= S	 <spawel523@gmail.com>
Date: Tue, 15 Sep 2026 15:13:33 +0200
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
References: <20260914181223.289061-1-seanjc@google.com>
Autocrypt: addr=jean-christophe@guillain.net; prefer-encrypt=mutual;
 keydata=mDMEaEmXaBYJKwYBBAHaRw8BAQdA1qyia8WH1pu6T8sC99WNMyKXooD/SVqJXsJOcnIux
 w20N0plYW4tQ2hyaXN0b3BoZSBHdWlsbGFpbiA8amVhbi1jaHJpc3RvcGhlQGd1aWxsYWluLm5ldD
 6IlgQTFgoAPhYhBDk2+TsBtH9ETCTubi9QTbKhgBdPBQJoSZdoAhsBBQkSzAMABQsJCAcCBhUKCQg
 LAgQWAgMBAh4BAheAAAoJEC9QTbKhgBdPrq0A/icNhFTYLybFWWq1B42UvJLGs18MNRiT5aLdFv3R
 DfHVAQCvzsLrC/qz4rOyIpDzeb0biOu3fiDTcyvV3kPiu3xTDA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-ovh-tracer-id: 4935382244483943228
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEaEanT6JS4IZxmbohpxZ+NZ0ZO5kRjEjm2F3QpeZU3e8QQe5w9r5nryv6f7VkSGHvyh28lwWJ6244qbNSdq9sh094CCYBnu1FyF7c9NJvMJfSrA/MHG4v2Gomy0QMSmfmfZAjhXQhet4Qgg+ueekaJ25/6eb1CKm3YIIIyMK6GBgRBpDqQTzzamNiu3dSBEEg5AAtKOAaHpovr2cfse+648CG9UC7+tinjF/27W43fP1oYRvCSfAHG/05l8NH30Nul3kZtYXDeMVOh3X84xvGsxx1AQKxm66xWv2R6zybxxK3RCcJd0VGPeH2Cgjb1m3Yl5b1z7a9B6bGl1hdPYRB9GlQhFD+k+cXBt4F6oisE6FkDpOQ6miuzQZWO1Z0XEYN+TYy5aDfuEtdwFqHFElIaMplJ8va9MkU8gEuKF77yfASNgnuIQ3ui2KNoae4JWFe3MUM0J2z+CtONG2sjsf0f3KICETTFzTVAzEMf18nxk40AM5d8Sfn7Dod9v/MhXLYqPPKe5kU/w9drwWIrlINtyTA7Lq9RLDUiy13snsfdcTVQI0cEFRmRlucQn8iGDaso8c77yIHwOt4UWzx3Cxe2HauNh19hKap/ugO5qZyDfNxqxCj43cbO7PF7EKf4bgMJOGWxVSHrvvK3L2seMRpbSOn89zf8WRrAtDmIDvPXBw
DKIM-Signature: a=rsa-sha256; bh=fjkxha1w+DbRNLwQvMI8D2L1jhJNUKlbrJxlN7jIlKg=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1789478015; v=1;
 b=IBJLAyxsoylAFO57NOnVh0r550ZdzFQcNQzRR/t1FuMOIQ/+u0LIre7rel8VJZ2O3mMWWGDA
 kK5mNEmL7NXZnec3Eim9K7ixwmsb/TaaY4LZThHTfw0pxCZcmE4Iiq9iX4B6f1o6SB1I5DdndYD
 Tl0wTM1fm4YIWow8FeSKrJ2u9F85Jo8LL8uO/ptJXIFj6YcsKRp9nZiALYmPTE8PkHxbghZ7DZQ
 9V+ID9tupaq3/owahx7C8lAdzQs4U5eXa4yJpSSQRGdTLqw7kmPjAAQq+qKdqyAjk0ffKIpwPmP
 aGbv9GqYkjWCGOCSa2ehG8wfiYayMQFyE0TdZCFAMVIsA==

Hi Sean,

I tested the full series with the configuration that originally
triggered the build failure (CONFIG_DEBUG_KERNEL=3Dn, CONFIG_KASAN=3Dn).

The kernel builds successfully, and I booted the resulting kernel and
started two QEMU/KVM VMs without any issues.

Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>

Thanks for the fix !

Cheers,
Jean-Christophe Guillain
